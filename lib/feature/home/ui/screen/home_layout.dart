import 'package:flutter/material.dart';
import 'package:restero/feature/cart/ui/screen/cart_screen.dart';
import 'package:restero/feature/home/ui/screen/home_screen.dart';
import 'package:restero/feature/menu/ui/screen/menu_screen.dart';
import 'package:restero/feature/profile/ui/screen/profile_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = const[
    HomeScreen(),
    MenuScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.3,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFFCC5920),
        unselectedItemColor: Color(0xFFDFD2C9),
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],

      ),
    );
  }
}
