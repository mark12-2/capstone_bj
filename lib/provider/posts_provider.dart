import 'package:capstone/model/posts_model.dart';
import 'package:capstone/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostsProvider with ChangeNotifier {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel?> fetchCurrentUserDetails() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final docRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        final docSnap = await docRef.get();

        if (docSnap.exists) {
          return UserModel.fromMap(docSnap.data() ?? {});
        } else {
          debugPrint("No user found!");
          return null;
        }
      } else {
        debugPrint("No current user signed in.");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      return null;
    }
  }

  // method to add a job post
  Future<DocumentReference> addPost(Post post) async {
    UserModel? currentUserDetails = await fetchCurrentUserDetails();

    if (currentUserDetails == null) {
      throw Exception('Current user details could not be fetched.');
    }

    return posts.add({
      "ownerId": currentUserDetails.uid,
      "name": currentUserDetails.name,
      "email": currentUserDetails.email,
      "role": currentUserDetails.role,
      "profilePic": currentUserDetails.profilePic,
      "title": post.title ?? '',
      "description": post.description,
      "type": post.type,
      "location": post.location ?? '',
      "rate": post.rate,
      "timestamp": Timestamp.now(),
    });
  }

  // read the post from firestore
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy("timestamp", descending: true)
        .snapshots();

    return postsStream;
  }

  // fetching users' own post
  Stream<QuerySnapshot> getSpecificPostsStream(String? userId) {
  if (userId == null || userId.isEmpty) {
    return Stream.empty(); 
  }
  return posts.where('ownerId', isEqualTo: userId).snapshots();
}
}
