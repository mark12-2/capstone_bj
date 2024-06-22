import 'package:capstone/provider/jobpost_provider.dart';
import 'package:capstone/provider/post_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homie extends StatefulWidget {
  const Homie({super.key});

  @override
  State<Homie> createState() => _HomieState();
}

class _HomieState extends State<Homie> {
  @override
  Widget build(BuildContext context) {
    final JobPostProvider jobpostdetails = JobPostProvider();
    final PostProvider createdPost = PostProvider();

    return Scaffold(
      appBar: AppBar(title: const Text("Ftchinng post")),
      body: StreamBuilder<QuerySnapshot>(
        stream: jobpostdetails.getJobPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final jobPosts = snapshot.data!.docs;

          return Expanded(
              child: ListView.builder(
                  itemCount: jobPosts.length,
                  itemBuilder: (context, index) {
                    final jobpost = jobPosts[index];

                    String name = jobpost['name'];
                    String title = jobpost['title'];
                    String description = jobpost['description'];

                    return ListTile(
                      title: Text(title),
                      subtitle: Text(name),
                      trailing: Text(description),
                    );
                  }));
        },
      ),
    );
  }
}
