import 'package:flutter/material.dart';
import 'package:online_shop/admin_pages/add_clothes_page.dart';
import 'package:online_shop/admin_pages/admin_page.dart';

import '../pages/about_page.dart';
import '../pages/intro_page.dart';

class AdminDrawerMenu extends StatelessWidget {
  final String userId;
  const AdminDrawerMenu({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              //logo of shop
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

              // Home
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  AdminPage(userId: userId)
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

              // Add clothes
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  AddClothesPage(userId: userId)
                        )
                    );
                  },
                  leading: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),

              // About Page
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

          // LogOut
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
