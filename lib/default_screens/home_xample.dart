import 'package:capstone/provider/jobpost_provider.dart';
import 'package:capstone/provider/post_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
//       body: StreamGroup.merge([
//   jobpostdetails.getJobPostsStream(),
//   createdPost.getPostsStream(),
// ]).flatMap((event) => event.docs).map((doc) => doc.data()).toList().then((posts) {
//   return ListView.builder(
//     itemCount: posts.length,
//     itemBuilder: (context, index) {
//       final post = posts[index];

//       // Display the post item
//     },
//   );
// }),
    );
  }
}
