import 'package:capstone/provider/posts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Posts')
                  .doc(widget.postId)
                  .collection('Comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot commentsSnapshot = snapshot.data!;
                  return ListView.builder(
                    itemCount: commentsSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot commentSnapshot =
                          commentsSnapshot.docs[index];
                      // time stmp
                      Timestamp createdAt = commentSnapshot['createdAt'];
                      String formattedTime =
                          DateFormat.jm().format(createdAt.toDate());

                      final currentUserId =
                          FirebaseAuth.instance.currentUser?.uid;

                      return ListTile(
                        title: Text(commentSnapshot['username']),
                        subtitle: Text(commentSnapshot['commentText']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(formattedTime),
                            commentSnapshot['userId'] == currentUserId
                                ? IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteComment(commentSnapshot.id);
                                    },
                                  )
                                : Container(), 
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentTextController,
                    decoration: const InputDecoration(
                      labelText: 'Add a comment',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_commentTextController.text.isNotEmpty) {
                      addComment(context, widget.postId);
                      _commentTextController.clear();
                    }
                  },
                  child: const Text('Add Comment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // adding a comment
  void addComment(BuildContext context, String postId) async {
    if (_commentTextController.text.isNotEmpty) {
      String comment = _commentTextController.text;

      try {
        await Provider.of<PostsProvider>(context, listen: false)
            .addComment(comment, postId);
        // You can add a success message here if you want
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment added successfully')),
        );
      } catch (e) {
        // Handle errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add comment: $e')),
        );
      }
    }
  }

  // deleting a comment
  void deleteComment(String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.postId)
          .collection('Comments')
          .doc(commentId)
          .delete();
      // You can add a success message here if you want
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment deleted successfully')),
      );
    } catch (e) {
      // Handle errors here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete comment: $e')),
      );
    }
  }
}
