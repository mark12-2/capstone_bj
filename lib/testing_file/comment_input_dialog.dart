import 'package:capstone/styles/textstyle.dart';
import 'package:flutter/material.dart';

class CommentInputDialog extends StatefulWidget {
  final String postId;

  const CommentInputDialog({required this.postId, super.key});

  @override
  State<CommentInputDialog> createState() => _CommentInputDialogState();
}

class _CommentInputDialogState extends State<CommentInputDialog> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add a comment',
                style: CustomTextStyle.semiBoldText,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add the comment to the post
                    // You'll need to implement the logic to add the comment to the post
                    // For example:
                    // PostsProvider.addComment(widget.postId, _commentController.text);
                    _commentController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




//   // method to add a comment to a post
// Future<void> addComment(String postId, String comment) async {
//   UserModel? currentUserDetails = await fetchCurrentUserDetails();

//   if (currentUserDetails == null) {
//     throw Exception('Current user details could not be fetched.');
//   }

//   final commentRef = FirebaseFirestore.instance
//       .collection('Posts')
//       .doc(postId)
//       .collection('Comments')
//       .doc();

//   await commentRef.set({
//     "name": currentUserDetails.name,
//     "email": currentUserDetails.email,
//     "profilePic": currentUserDetails.profilePic,
//     "comment": comment,
//     "timestamp": Timestamp.now(),
//   });
// }