// // import 'package:bluejobs_user/styles/custom_theme.dart';
// // import 'package:flutter/material.dart';

// // class SearchPage extends StatefulWidget {
// //   const SearchPage({super.key});

// //   @override
// //   State<SearchPage> createState() => _SearchPageState();
// // }

// // class _SearchPageState extends State<SearchPage> {
// //   final TextEditingController _searchController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.all(10),
// //             child: TextField(
// //               controller: _searchController,
// //               decoration: customInputDecoration('Search...'),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }


// // // import 'package:flutter/material.dart';

// // // class SearchPage extends StatefulWidget {
// // //  @override
// // //  _SearchPageState createState() => _SearchPageState();
// // // }

// // // class _SearchPageState extends State<SearchPage> {
// // //  List<String> searchItems = [];
// // //  TextEditingController searchController = TextEditingController();

// // //  void addSearchItem(String item) {
// // //     setState(() {
// // //       searchItems.add(item);
// // //     });
// // //     searchController.clear();
// // //  }

// // //  void removeSearchItem(int index) {
// // //     setState(() {
// // //       searchItems.removeAt(index);
// // //     });
// // //  }

// // //  @override
// // //  Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Search Page'),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: TextField(
// // //               controller: searchController,
// // //               decoration: InputDecoration(
// // //                 labelText: 'Search',
// // //                 suffixIcon: IconButton(
// // //                  icon: Icon(Icons.search),
// // //                  onPressed: () => addSearchItem(searchController.text),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: searchItems.length,
// // //               itemBuilder: (context, index) {
// // //                 return ListTile(
// // //                  title: Text(searchItems[index]),
// // //                  trailing: Row(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       IconButton(
// // //                         icon: Icon(Icons.edit),
// // //                         onPressed: () {
// // //                           // Navigate to EditSearchPage
// // //                           Navigator.push(
// // //                             context,
// // //                             MaterialPageRoute(
// // //                               builder: (context) => EditSearchPage(
// // //                                 //searchItem: searchItems[index],
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                       ),
// // //                       IconButton(
// // //                         icon: Icon(Icons.close),
// // //                         onPressed: () => removeSearchItem(index),
// // //                       ),
// // //                     ],
// // //                  ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //  }
// // // }

// // // class EditSearchPage extends StatefulWidget {
// // //   const EditSearchPage({super.key});

// // //   @override
// // //   State<EditSearchPage> createState() => _EditSearchPageState();
// // // }

// // // class _EditSearchPageState extends State<EditSearchPage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return const Placeholder();
// // //   }
// // // }



// import 'package:bluejobs_user/styles/custom_theme.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//  const SearchPage({super.key});

//  @override
//  State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//  final TextEditingController _searchController = TextEditingController();

//  @override
//  void dispose() {
//     _searchController.dispose();
//     super.dispose();
//  }

//  void _showSearchResults(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Search Results'),
//           content: Container(
//             width: double.maxFinite,
//             child: ListView.builder(
//               itemCount: 5, // Example count, replace with actual search results
//               itemBuilder: (context, index) {
//                 return ListTile(
//                  title: Text('Result $index'), // Replace with actual search result data
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//  }

//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () => _showSearchResults(context),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: TextField(
//               controller: _searchController,
//               decoration: customInputDecoration('Search...'),
//             ),
//           ),
//         ],
//       ),
//     );
//  }
// }

// import 'package:flutter/material.dart';
// import 'package:bluejobs_user/styles/custom_theme.dart';

// class SearchResultsPage extends StatefulWidget {
//  final String query;

//  const SearchResultsPage({Key? key, required this.query}) : super(key: key);

//  @override
//  _SearchResultsPageState createState() => _SearchResultsPageState();
// }

// class _SearchResultsPageState extends State<SearchResultsPage> {
//  // Example list of users. Replace with actual data.
//  final List<Map<String, dynamic>> users = [
//     {'username': 'User1', 'profilePic': 'https://example.com/user1.png'},
//     {'username': 'User2', 'profilePic': 'https://example.com/user2.png'},
//     // Add more users as needed
//  ];

//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Results for "${widget.query}"'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(users[index]['profilePic']),
//             ),
//             title: Text(users[index]['username']),
//           );
//         },
//       ),
//     );
//  }
// }


// import 'package:bluejobs_user/styles/custom_theme.dart';
// import 'package:flutter/material.dart';

// class SearchResultsPage extends StatefulWidget {
//  final String query;

//  const SearchResultsPage({Key? key, required this.query}) : super(key: key);

//  @override
//  _SearchResultsPageState createState() => _SearchResultsPageState();
// }

// class _SearchResultsPageState extends State<SearchResultsPage> {
//  // Example list of users. Replace with actual data.
//  final List<Map<String, dynamic>> users = [
//     {'username': 'User1', 'profilePic': 'https://example.com/user1.png'},
//     {'username': 'User2', 'profilePic': 'https://example.com/user2.png'},
//     // Add more users as needed
//  ];

//  final TextEditingController _searchController = TextEditingController();

//  @override
//  void initState() {
//     super.initState();
//     _searchController.text = widget.query; // Set the initial text to the search query
//  }

//  @override
//  void dispose() {
//     _searchController.dispose();
//     super.dispose();
//  }

//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        // title: Text('Search Results for "${widget.query}"'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Text('Search for "${widget.query}"'), ),
//              Padding( padding: EdgeInsets.all(10),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search...',
//                 suffixIcon: IconButton(
//                  icon: Icon(Icons.search),
//                  onPressed: () {
//                     // Implement search functionality here
//                     // For example, you could navigate back to the SearchPage with the new query
//                  },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                  leading: CircleAvatar(
//                     backgroundImage: NetworkImage(users[index]['profilePic']),
//                  ),
//                  title: Text(users[index]['username']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//  }
// }

// class SearchPage extends StatefulWidget {
//  const SearchPage({super.key});

//  @override
//  State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//  final TextEditingController _searchController = TextEditingController();

//  @override
//  void dispose() {
//     _searchController.dispose();
//     super.dispose();
//  }
// void _showSearchResults(BuildContext context) {
//  final String query = _searchController.text;
//  Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SearchResultsPage(query: query),
//     ),
//  );
// }

//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//          children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: TextField(
//               controller: _searchController,
//               decoration: customInputDecoration('Search...').copyWith(
//                 suffixIcon: IconButton(
//                  icon: Icon(Icons.search),
//                  onPressed: () => _showSearchResults(context),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//  }
// }

import 'package:flutter/material.dart';
import 'package:capstone/styles/custom_theme.dart'; // Ensure this import is correct

class SearchPage extends StatefulWidget {
 const SearchPage({super.key});

 @override
 State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
 final TextEditingController _searchController = TextEditingController();
 // Example list of users. Replace with actual data.
 List<Map<String, dynamic>> users = [];

 @override
 void dispose() {
    _searchController.dispose();
    super.dispose();
 }

 void _showSearchResults(BuildContext context) {
    // Simulate fetching search results based on the query
    // In a real application, you would replace this with actual data fetching logic
    setState(() {
      users = [
        {'username': 'User1', 'profilePic': 'https://example.com/user1.png'},
        {'username': 'User2', 'profilePic': 'https://example.com/user2.png'},
        // Add more users as needed
      ];
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: customInputDecoration('Search...').copyWith(
                suffixIcon: IconButton(
                 icon: Icon(Icons.search),
                 onPressed: () => _showSearchResults(context),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                 leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index]['profilePic']),
                 ),
                 title: Text(users[index]['username']),
                );
              },
            ),
          ),
        ],
      ),
    );
 }
}