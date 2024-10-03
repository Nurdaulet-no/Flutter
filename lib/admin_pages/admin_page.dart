import 'package:flutter/material.dart';
import 'package:online_shop/admin_component/admin_bottom_nav_bar.dart';
import 'package:online_shop/admin_component/admin_drawer_menu.dart';
import 'package:online_shop/admin_pages/review_page.dart';
import 'package:online_shop/models/cart.dart';
import 'package:online_shop/pages/shop_page.dart';
import 'package:online_shop/providers/clothes_provider.dart';
import 'package:provider/provider.dart';



class AdminPage extends StatefulWidget {
  final String userId;
  const AdminPage({super.key, required this.userId});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  bool _isGridView = false; // Flag to maintain the grid view state

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Consumer<ClothesProvider>(builder: (context, clothesProvider, child) {
        return ShopPage(
          clothes: clothesProvider.clothesList,
          userId: widget.userId,
          isGridView: _isGridView,
          onGridViewToggle: (value) {
            setState(() {
              _isGridView = value;
            });
            print('isGridView: ${_isGridView}');
          },
        );
      }),
      const ReviewPage()
    ];
    return ChangeNotifierProvider(
      create: (context) => Cart(widget.userId),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          bottomNavigationBar: AdminBottomNavBar(
            onTabChange: (index) => navigateBottomBar(index),
          ),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Padding(
                    padding:  EdgeInsets.all(10),
                    child: Icon(Icons.menu),
                  ),
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.more_vert_outlined)
              )
            ],
          ),

          // Drawer Menu
          drawer:  AdminDrawerMenu(userId: widget.userId),

          body: _pages[_selectedIndex],
        );
      }
    );
  }

  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
