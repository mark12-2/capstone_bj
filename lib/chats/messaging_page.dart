import 'package:capstone/chats/messaging_roompage.dart';
import 'package:capstone/provider/messaging/messaging_services.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: FutureBuilder<UserModel?>(
          future: _chatService.fetchCurrentUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final currentUser = snapshot.data!;
            return StreamBuilder<QuerySnapshot>(
              stream: _chatService.getUserChatRooms(currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final chatRooms = snapshot.data!.docs;

                if (chatRooms.isEmpty) {
                  return const Center(child: Text('No Messages'));
                }

                return ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = chatRooms[index];
                    final chatRoomData =
                        chatRoom.data() as Map<String, dynamic>;

                    // Get the other user's ID and name
                    final otherUserId = chatRoomData['users']
                        .firstWhere((userId) => userId != currentUser.uid);
                    final otherUserName =
                        chatRoomData['userNames'][otherUserId];

                    // Get the last message
                    // final messages = chatRoomData['messages'];
                    // String lastMessageText = 'No messages';
                    // if (messages != null && messages.isNotEmpty) {
                    //   final lastMessage = messages.last;
                    //   lastMessageText = lastMessage['message'];
                    // }

                    return ListTile(
                      title: Text(
                        otherUserName,
                        style: CustomTextStyle.semiBoldText
                            .copyWith(fontSize: responsiveSize(context, 0.04)),
                      ),
                      subtitle: Text(
                        // lastMessageText,
                        'View message',
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
                  },
                );
              },
            );
          }),
    );
  }
}
