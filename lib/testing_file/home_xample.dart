import 'package:capstone/provider/posts_provider.dart';
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
    // final JobPostProvider jobpostdetails = JobPostProvider();
    // final PostProvider createdPost = PostProvider();

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






// design
//  Card(
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           elevation: 4.0,
//                           margin:
//                               const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(profilePic),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     Text(
//                                       '$name',
//                                       style: CustomTextStyle.regularText
//                                           .copyWith(
//                                               color: const Color.fromARGB(
//                                                   255, 0, 0, 0),
//                                               fontSize: responsiveSize(
//                                                   context, 0.04)),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   "$description",
//                                   style: CustomTextStyle.semiBoldText,
//                                 ),
//                                 const SizedBox(height: 15),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   "$rate",
//                                   style: CustomTextStyle.regularText,
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                           Icons.thumb_up_alt_rounded),
//                                       onPressed: () {
//                                         // Add logic for liking the post
//                                       },
//                                     ),
//                                     const Text(
//                                       'React',
//                                       style: CustomTextStyle.regularText,
//                                     ),
//                                     const SizedBox(width: 85),
//                                     InkWell(
//                                       onTap: () {
//                                         // Toggle visibility of comment input field and post button
//                                         setState(() {
//                                           _showCommentInput =
//                                               !_showCommentInput;
//                                         });
//                                       },
//                                       child: const Text(
//                                         'Comment',
//                                         style: CustomTextStyle.regularText,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: _showCommentInput,
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start, // Align items at the start of the cross axis
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           height: 53,
//                                           child: TextFormField(
//                                             controller:
//                                                 _commentController, // Define a TextEditingController
//                                             decoration: const InputDecoration(
//                                               hintText: 'Write your comment...',
//                                               hintStyle:
//                                                   CustomTextStyle.regularText,
//                                               border: OutlineInputBorder(),
//                                             ),
//                                             minLines: 1,
//                                             maxLines: 3,
//                                             textAlignVertical:
//                                                 TextAlignVertical.center,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Container(
//                                         height:
//                                             53, // Set the height of the container
//                                         width: 70,
//                                         decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                               255,
//                                               7,
//                                               30,
//                                               47), // Set the background color to blue
//                                           borderRadius: BorderRadius.circular(
//                                               5), // Set the border radius to 5
//                                         ),
//                                         child: InkWell(
//                                           onTap: () {
//                                             // Add logic for posting the comment
//                                             // String commentText = _commentController.text;
//                                             // Process the commentText (e.g., post it, clear the input field, etc.)
//                                             // Clear the input field
//                                             _commentController.clear();
//                                             // Hide the comment input field and post button after posting the comment
//                                             setState(() {
//                                               _showCommentInput = false;
//                                             });
//                                           },
//                                           child: Center(
//                                             child: Text(
//                                               'Post',
//                                               style: CustomTextStyle.regularText
//                                                   .copyWith(
//                                                       color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )