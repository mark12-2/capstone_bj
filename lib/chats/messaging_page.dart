import 'package:capstone/chats/messaging_roompage.dart';
import 'package:capstone/provider/messaging/messaging_services.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: FutureBuilder<UserModel?>(
        future: _chatService.fetchCurrentUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final currentUser = snapshot.data!;
          return StreamBuilder<QuerySnapshot>(
            stream: _chatService.getUserChatRooms(currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final chatRooms = snapshot.data!.docs;

              if (chatRooms.isEmpty) {
                return Center(child: Text('No chat rooms'));
              }

              return ListView.builder(
                itemCount: chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRooms[index];
                  final chatRoomData = chatRoom.data() as Map<String, dynamic>;
                  final otherUserId = chatRoomData['users']
                      .firstWhere((userId) => userId != currentUser.uid);
                  final otherUserName = chatRoomData['name'][otherUserId];
                  final lastMessage = chatRoomData['messages'][
                      0]; 

                  if (lastMessage != null) {
                    return ListTile(
                      title: Text(
                        otherUserName,
                        style: CustomTextStyle.semiBoldText
                            .copyWith(fontSize: responsiveSize(context, 0.04)),
                      ),
                      subtitle: Text(
                        lastMessage['message'],
                        style: CustomTextStyle.regularText
                            .copyWith(fontSize: responsiveSize(context, 0.03)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagingBubblePage(
                              receiverId: otherUserId,
                              receiverName: otherUserName,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListTile(
                      title: Text(
                        otherUserName,
                        style: CustomTextStyle.semiBoldText
                            .copyWith(fontSize: responsiveSize(context, 0.04)),
                      ),
                      subtitle: Text(
                        'No messages',
                        style: CustomTextStyle.regularText
                            .copyWith(fontSize: responsiveSize(context, 0.03)),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
