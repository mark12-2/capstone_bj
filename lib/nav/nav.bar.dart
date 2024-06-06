
import 'package:flutter/material.dart';
import 'package:capstone/screensforhome/create_post.dart';
import 'package:capstone/screensforhome/home.dart';
// import 'package:capstone/screensforhome/messaging.dart';
import 'package:capstone/screensforhome/search.dart';
import 'package:capstone/screensforhome/profile_page.dart';


class NavBarPage extends StatefulWidget {
 const NavBarPage({super.key});

 @override
 State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
 int _selectedIndex = 0;
 List<Widget> screensforhome = <Widget>[
    HomePage(),
    SearchPage(),
    CreatePostPage(),
    // MessagingPage(),
    ProfilePage(),
    
    
 ];

 @override
 Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: screensforhome[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded),label: 'Search',),
          BottomNavigationBarItem(icon: Icon(Icons.add_box),label: 'Create ',),
          BottomNavigationBarItem(icon: Icon(Icons.message),label: 'Chats',),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',),
        ],
        unselectedItemColor: Color.fromARGB(255, 19, 8, 8),
        selectedItemColor: Color.fromARGB(255, 7, 16, 69),
        currentIndex: _selectedIndex,
        //onTap: _onItemTapped,
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


class EmployerNavBarPage extends StatefulWidget {
  const EmployerNavBarPage({super.key});

  @override
  State<EmployerNavBarPage> createState() => _EmployerNavBarPageState();
}

class _EmployerNavBarPageState extends State<EmployerNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

