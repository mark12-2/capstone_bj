import 'package:capstone/model/message_model.dart';
import 'package:capstone/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> fetchCurrentUserDetails() async {
    try {
      final currentUser = _auth.currentUser;
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

  // sending messsage
  Future<void> sendMessage(String receiverId, message) async {
    final UserModel? currentUserDetails = await fetchCurrentUserDetails();
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserName = currentUserDetails!.name;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add new message to database
    await _firestore
        .collection('message rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // receive the message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('message rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserChatRooms(String userId) {
    return _firestore
        .collection('message rooms')
        .where('users', arrayContains: userId)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots();
  }
}
