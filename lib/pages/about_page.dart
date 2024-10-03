import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/admin_component/admin_drawer_menu.dart';
import 'package:online_shop/components/drawer_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/models/about_content.dart';
import 'package:online_shop/models/user.dart';

class AboutPage extends StatefulWidget {
  final String userId;
  const AboutPage({super.key, required this.userId});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isAdmin = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadAboutContent();
    _checkIfAdmin();
  }

  void _loadAboutContent() async {
    final aboutBox = await Hive.openBox<AboutContent>('aboutBox');
    final aboutContent = aboutBox.get('aboutContent') ?? AboutContent();
    _textController.text = aboutContent.textContent;
  }

  void _checkIfAdmin() async {
    final loggedInUserBox = await Hive.openBox('loggedInUserBox');
    final loggedInUsername = loggedInUserBox.get('loggedInUsername');

    if (loggedInUsername != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final currentUser = userBox.get(loggedInUsername);

      if (currentUser != null && currentUser.isAdmin) {
        setState(() {
          _isAdmin = true;
        });
      } else {
        setState(() {
          _isAdmin = false;
        });
      }
    }

    print('Is admin: $_isAdmin');
  }

  void _saveAboutContent() async {
    final aboutBox = await Hive.openBox<AboutContent>('aboutBox');
    final aboutContent = AboutContent()..textContent = _textController.text;
    aboutBox.put('aboutContent', aboutContent);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Content saved successfully')),
    );
  }

  void _editing() {
    setState(() {
      if(_isEditing) {
        _saveAboutContent();
      }

      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.menu),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      drawer: _isAdmin ?  AdminDrawerMenu(userId: widget.userId) :  DrawerMenu(userId: widget.userId),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Us📑',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _textController,
                  decoration:  InputDecoration(
                    border: _isEditing ? const OutlineInputBorder() : InputBorder.none,
                  ),
                  maxLines: null,
                  readOnly: !_isEditing,
                ),
                const SizedBox(height: 8),

                if (_isAdmin)
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: _editing,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if(states.contains(WidgetState.pressed)) {
                              return const Color(0xFFBDBDBD);
                            }else if(_isEditing){
                              return const Color(0xFFA5D6A7);
                            }else{
                              return Colors.grey;
                            }
                          }
                        ),

                      ),
                      child:  Text(
                          _isEditing ? 'Save' : 'Edit',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 60),

              ],
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Instagram button press
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Icon(
                            FontAwesomeIcons.instagram,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(width: 5),
                        Text(
                            'Instagram',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle WhatsApp button press
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Icon(
                            FontAwesomeIcons.whatsapp,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(width: 5),
                        Text(
                            'WhatsApp',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
