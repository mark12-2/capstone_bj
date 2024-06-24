import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/provider/posts_provider.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    final PostsProvider _postsProvider = PostsProvider();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetching owners' posts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _userId != null
                  ? _postsProvider.getSpecificPostsStream(_userId)
                  : Stream.empty(),
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
                      String title = post['title'];
                      String description = post['description'];
                      String type = post['type'];
                      String location = post['location'];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$name",
                                          style: CustomTextStyle.semiBoldText
                                              .copyWith(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize:
                                                responsiveSize(context, 0.05),
                                          ),
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
