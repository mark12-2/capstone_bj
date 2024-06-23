import 'package:capstone/default_screens/home.dart';
import 'package:capstone/default_screens/messaging.dart';
import 'package:capstone/default_screens/search.dart';
import 'package:capstone/employer_screens/employer_profile.dart';
import 'package:capstone/jobhunter_screens/create_post.dart';
import 'package:flutter/material.dart';

class JobhunterNavigation extends StatefulWidget {
  const JobhunterNavigation({super.key});

  @override
  State<JobhunterNavigation> createState() => _JobhunterNavigationState();
}

class _JobhunterNavigationState extends State<JobhunterNavigation> {
  int _selectedIndex = 0;
  List<Widget> defaultScreens = <Widget>[
    const HomePage(),
    const SearchPage(),
    const PostPage(),
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
        unselectedItemColor: const Color.fromARGB(255, 19, 8, 8),
        selectedItemColor: const Color.fromARGB(255, 7, 16, 69),
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
