import 'package:capstone/default_screens/view_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capstone/styles/custom_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchUsers() async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final usersSnapshot = await usersRef.get();
    List<Map<String, dynamic>> allUsers = usersSnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'name': doc.get('name'),
        'profilePic': doc.get('profilePic'),
        'role': doc.get('role'),
      };
    }).toList();
    setState(() {
      _allUsers = allUsers;
      _filteredUsers = allUsers;
    });
  }

  void _filterUsers(String query) {
    query = query.toLowerCase();
    List<Map<String, dynamic>> filteredUsers = _allUsers.where((user) {
      return user['name'].toLowerCase().contains(query);
    }).toList();
    setState(() {
      _filteredUsers = filteredUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: customInputDecoration('Search users...').copyWith(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _filterUsers(_searchController.text);
                  },
                ),
              ),
              onChanged: (value) {
                _filterUsers(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                var user = _filteredUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['profilePic']),
                  ),
                  title: Text(user['name']),
                  subtitle: Text(user['role']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(userId: user['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
