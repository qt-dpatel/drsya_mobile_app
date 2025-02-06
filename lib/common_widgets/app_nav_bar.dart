import 'package:drsya_mobile_app/history/history.dart';
import 'package:drsya_mobile_app/home/home_screen.dart';
import 'package:drsya_mobile_app/profile/profile.dart';
import 'package:drsya_mobile_app/survey_screens/my_surveys.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({super.key});
  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(),
      MySurveys(),
      History(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Color.fromRGBO(5, 30, 41, 1), // Background color
            height: 60,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Color.fromRGBO(243, 111, 52, 1),
              unselectedItemColor: Color.fromRGBO(134, 136, 138, 1),
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: "My Surveys",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: "History",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 58, // Adjust to position the indicator above tabs
            left: MediaQuery.of(context).size.width / 4 * _selectedIndex +
                MediaQuery.of(context).size.width / 8 -
                25,
            child: Container(
              width: 50,
              height: 2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 111, 52, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
