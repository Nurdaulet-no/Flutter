import 'package:flutter/material.dart';
import 'package:online_shop/components/bottom_nav_bar.dart';
import 'package:online_shop/components/drawer_menu.dart';
import 'package:online_shop/components/expand_page.dart';
import 'package:online_shop/models/cart.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:online_shop/pages/shop_page.dart';
import 'package:online_shop/providers/clothes_provider.dart';
import 'package:provider/provider.dart';
import 'cart_page.dart';


class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isGridView = false; // Flag to maintain the grid view state

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Consumer<ClothesProvider>(
        builder: (context, clothesProvider, child) {
        return ShopPage(
          clothes: clothesProvider.clothesList,
          userId: widget.userId,
          isGridView: _isGridView,
          onGridViewToggle: (value) {
            setState(() {
              _isGridView = value;
            });
          },
        );
      }),
      const CartPage()
    ];
    return ChangeNotifierProvider(
      create: (context) => Cart(widget.userId),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          bottomNavigationBar: MyBottomNavBar(
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
          ),

          // Drawer Menu
          drawer:  DrawerMenu(userId: widget.userId),

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
