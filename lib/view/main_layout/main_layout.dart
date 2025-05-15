import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../utlis/app_colors.dart';
import '../home_screen/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _activeIdx = 0;
  List<Widget> _screens = [HomeScreen(), Scaffold(), Scaffold(), Scaffold()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (value) {
            setState(() {
              _activeIdx = value;
            });
          },
          tabBorderRadius: 6,
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 400), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: AppColors.kIconColor, // unselected icon color
          activeColor: AppColors.kPrimaryColor, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: AppColors.kPrimaryColor.withOpacity(
            0.2,
          ), // selected tab background color
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ), // navigation bar padding
          tabs: [
            GButton(icon: LineIcons.home, text: 'Home'),
            GButton(icon: LineIcons.shoppingBag, text: 'Categories'),
            GButton(icon: LineIcons.search, text: 'Search'),
            GButton(icon: LineIcons.user, text: 'Profile'),
          ],
        ),
      ),
      body: _screens[_activeIdx],
    );
  }
}
