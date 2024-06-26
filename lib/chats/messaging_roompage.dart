import 'package:capstone/chats/chatbubble.dart';
import 'package:capstone/provider/messaging/messaging_services.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagingBubblePage extends StatelessWidget {
  final String receiverName;
  final String receiverId;

  MessagingBubblePage(
      {super.key, required this.receiverName, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      // clear message after sending
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverName)),
      body: Column(
        children: [
          // display messsages
          Expanded(child: _buildMessageList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderId = _auth.currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(context, doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(BuildContext context, DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: alignment,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          data['senderName'] == _auth.currentUser!.uid
              ? Container()
              : Text(
                  data['senderName'],
                  style: CustomTextStyle.chatusernameRegularText,
                ),
          Chatbubble(
            message: data['message'],
          )
        ]),
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type message...',
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
