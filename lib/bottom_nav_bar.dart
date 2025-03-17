import 'package:flutter/material.dart';
import 'package:task/account/account_screen.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/review/home_screen.dart';
import 'package:task/review/review_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({required this.email, super.key});
  final String email;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  
  
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
     HomeScreen(email:widget.email),
     ReviewScreen(email:widget.email),
     AccountScreen(email:widget.email),
  ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppColor.primary,
            onTap: (value) {
              currentIndex = value;
              setState(() {});
            },
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.reviews_outlined, size: 30),
                label: "MyReview",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined, size: 30),
                label: "Account",
              ),
            ],
          ),
        ),

        body: tabs[currentIndex],
      ),
    );
  }
}
