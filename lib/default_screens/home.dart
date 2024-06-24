// import 'package:capstone/testing_file/comment_input_dialog.dart';
import 'package:capstone/testing_file/employer_jobpost_view.dart';
import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/provider/posts_provider.dart';
import 'package:capstone/screens_for_auth/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capstone/default_screens/notification.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userLoggedIn = Provider.of<AuthProvider>(context, listen: false);
    final PostsProvider postDetails = Provider.of<PostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
          child: Image.asset('assets/images/bluejobs.png'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              userLoggedIn.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: postDetails.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No posts available"),
                  );
                }

                final posts = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      String name = post['name'];
                      String role = post['role'];
                      String profilePic = post['profilePic'];
                      String title = post['title']; // for job post
                      String description = post['description'];
                      String type = post['type'];
                      String location = post['location']; // for job post
                      String rate = post['rate'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 4.0,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(profilePic),
                                      radius: 35.0,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "$name",
                                          style: CustomTextStyle.semiBoldText
                                              .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: responsiveSize(
                                                      context, 0.05)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 55.0),
                                          child: Text(
                                            "$role",
                                            style:
                                                CustomTextStyle.roleRegularText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),
                                // post description
                                Text(
                                  "$description",
                                  style: CustomTextStyle.regularText,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Type of Job: $type",
                                  style: CustomTextStyle.typeRegularText,
                                ),
                                Text(
                                  "Rate: $rate",
                                  style: CustomTextStyle.semiBoldText,
                                ),

                                const SizedBox(height: 15),

                                // supposed to be comment
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Display comment input field
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return CommentInputDialog(
                                        //         postId: post.id);
                                        //   },
                                        // );
                                      },
                                      child: Container(
                                        height: 53,
                                        width: 165, // Adjust width as needed
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 7,
                                              30, 47), // Background color
                                          borderRadius: BorderRadius.circular(
                                              5), // Border radius
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Comment',
                                            style: CustomTextStyle.regularText
                                                .copyWith(
                                              color: Colors.white,
                                              fontSize:
                                                  responsiveSize(context, 0.03),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width: 10), // Space between buttons

                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EmployerJobpostView(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 53,
                                        width: 165, // Adjust width as needed
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.orange, // Border color
                                            width: 2, // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              5), // Border radius
                                          color: Colors.white, // Background
                                        ),
                                        child: Center(
                                          child: Text(
                                            'View Post',
                                            style: CustomTextStyle.regularText
                                                .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize:
                                                  responsiveSize(context, 0.03),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
