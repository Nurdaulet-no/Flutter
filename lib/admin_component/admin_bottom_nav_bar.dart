import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class AdminBottomNavBar extends StatelessWidget {
  void Function(int) ? onTabChange;
  AdminBottomNavBar({
    super.key,
    required this.onTabChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Магазин',
          ),
          GButton(
            icon: Icons.reviews,
            text: 'Отзывы',
          ),
        ],
      ),
    );
  }
}
