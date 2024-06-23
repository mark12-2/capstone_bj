import 'package:capstone/model/jobpost_model.dart';
import 'package:capstone/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class JobPostProvider with ChangeNotifier {
  final CollectionReference jobPosts =
      FirebaseFirestore.instance.collection('Job Post');
  final FirebaseAuth auth = FirebaseAuth.instance;

  // fetch userlogged in details from Firestore
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
 Future<DocumentReference> addJobPost(JobPost jobpost) async {
  UserModel? currentUserDetails = await fetchCurrentUserDetails();

  if (currentUserDetails == null) {
    throw Exception('Current user details could not be fetched.');
  }

  return jobPosts.add({
    "name": currentUserDetails.name,
    "email": currentUserDetails.email,
    "role": currentUserDetails.role,
    "profilePic": currentUserDetails.profilePic,
    "title": jobpost.title,
    "description": jobpost.description,
    "type": jobpost.type,
    "location": jobpost.location,
    "rate": jobpost.rate,
    "timestamp": Timestamp.now(),
  });
}

  // read the post from firestore
  Stream<QuerySnapshot> getJobPostsStream() {
    final jobPostsStream = FirebaseFirestore.instance
        .collection('Job Post')
        .orderBy("timestamp", descending: true)
        .snapshots();

    return jobPostsStream;
  }
}
