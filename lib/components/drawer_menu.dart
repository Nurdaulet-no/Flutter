import 'package:flutter/material.dart';
import 'package:online_shop/pages/wallet_page.dart';

import '../pages/about_page.dart';
import '../pages/home_page.dart';
import '../pages/intro_page.dart';

class DrawerMenu extends StatelessWidget {
  final String userId;
  const DrawerMenu({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                  child: Image.asset(
                      'assets/images/img.png'
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey[700],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomePage(userId: userId)
                        )
                    );
                  },
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  WalletPage(userId: userId))
                    );
                  },
                  leading: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Wallet',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AboutPage(userId: userId))
                    );
                  },
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 25),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IntroPage())
                );
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
