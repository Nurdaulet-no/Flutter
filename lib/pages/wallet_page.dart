import 'package:flutter/material.dart';

import '../components/drawer_menu.dart';

class WalletPage extends StatefulWidget {
  final String userId;
  const WalletPage({super.key, required this.userId});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String currentBalance = '350000';

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
                padding:  EdgeInsets.all(10),
                child: Icon(Icons.menu),
              ),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            ),
          )
      ),

      // Drawer Menu
      drawer:  DrawerMenu(userId: widget.userId),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Your balance: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '\$'+currentBalance,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
