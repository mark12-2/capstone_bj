import 'package:capstone/default_screens/mapping.dart';
import 'package:capstone/default_screens/messaging.dart';
import 'package:capstone/default_screens/search.dart';
import 'package:capstone/employer_screens/create_jobpost.dart';
import 'package:capstone/employer_screens/employer_profile.dart';
import 'package:capstone/screens_for_auth/home_screen.dart';
import 'package:flutter/material.dart';

class EmployerNavigation extends StatefulWidget {
  const EmployerNavigation({super.key});

  @override
  State<EmployerNavigation> createState() => _EmployerNavigationState();
}

class _EmployerNavigationState extends State<EmployerNavigation> {
  int _selectedIndex = 0;
  List<Widget> defaultScreens = <Widget>[
    const HomeScreen(),
    // const Mapping(),
    const CreateJobPostPage(),
    const MessagingPage(),
    const EmployerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: defaultScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Color.fromARGB(255, 19, 8, 8),
        selectedItemColor: Color.fromARGB(255, 7, 16, 69),
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}