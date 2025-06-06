import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _currentIndex = 0;
  final pages = [HomeScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CircleNavBar(
        activeIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 60.h,
        circleWidth: 40.w,
        cornerRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        activeIcons: [
          Icon(Icons.dashboard_outlined, color: theme.scaffoldBackgroundColor),
          Icon(Icons.shopping_cart_outlined),
          Icon(
            Icons.account_circle_outlined,
            color: theme.scaffoldBackgroundColor,
          ),
        ],
        inactiveIcons: [
          Icon(Icons.dashboard, color: theme.scaffoldBackgroundColor),
          Icon(Icons.shopping_cart, color: theme.scaffoldBackgroundColor),
          Icon(Icons.account_circle, color: theme.scaffoldBackgroundColor),
        ],
        color: theme.primaryColor,
      ),
    );
  }
}
