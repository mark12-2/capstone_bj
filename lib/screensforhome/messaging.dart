// // import 'package:flutter/material.dart';

// // class MessagingPage extends StatefulWidget {
// //   const MessagingPage({super.key});

// //   @override
// //   State<MessagingPage> createState() => _MessagingPageState();
// // }

// // class _MessagingPageState extends State<MessagingPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Text('hahahah'),

// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// // import 'package:capstone/models/message_model.dart';
// import 'package:capstone/styles/textstyle.dart';
// import 'package:capstone/styles/responsive_utils.dart';

// class MessagingPage extends StatefulWidget {
//   @override
//   _MessagingPageState createState() => _MessagingPageState();
// }

// class _MessagingPageState extends State<MessagingPage> {
//   // Example list of messages. Replace with actual data.
//   // List<Message> messages = [
//   //   Message(
//   //       username: 'User1', content: 'Hello, how are you?', date: '2023-04-01'),
//   //   Message(
//   //       username: 'User2', content: 'I\'m good, thanks!', date: '2023-04-02'),
//   //   // Add more messages as needed
//   // ];
//   List<Message> messages = [
//     Message(
//         username: 'User1',
//         content: 'Hello, how are you?',
//         date: '2023-04-01',
//         profilePicUrl: 'https://example.com/user1.jpg'), // Add profilePicUrl
//     Message(
//         username: 'User2',
//         content: 'I\'m good, thanks!',
//         date: '2023-04-02',
//         profilePicUrl: 'https://example.com/user2.jpg'), // Add profilePicUrl
//     // Add more messages as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages'),
//       ),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 30,
//               backgroundImage: NetworkImage(
//                 messages[index].profilePicUrl,
//               ), // Use NetworkImage for URLs
//               // Or use AssetImage for local assets
//               // backgroundImage: AssetImage(messages[index].profilePicUrl),
//             ),
//             title: Text(messages[index].username,
//                 style: CustomTextStyle.semiBoldText
//                     .copyWith(fontSize: responsiveSize(context, 0.04))),
//             subtitle: Text(messages[index].content,
//                 style: CustomTextStyle.regularText
//                     .copyWith(fontSize: responsiveSize(context, 0.03))),
//             trailing: Text(messages[index].date,
//                 style: CustomTextStyle.LightText.copyWith(
//                     fontSize: responsiveSize(context, 0.03))),
//             onTap: () {
//               // Navigate to the detailed message view
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       MessageDetailPage(message: messages[index]),
//                 ),
//               );
//             },
//             onLongPress: () {
//               // Show options to delete or mute the message
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Options'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           title: Text('Delete'),
//                           onTap: () {
//                             // Implement delete functionality
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         ListTile(
//                           title: Text('Mute'),
//                           onTap: () {
//                             // Implement mute functionality
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // class MessageDetailPage extends StatefulWidget {
// //   final Message message;

// //   const MessageDetailPage({Key? key, required this.message}) : super(key: key);

// //   @override
// //   _MessageDetailPageState createState() => _MessageDetailPageState();
// // }

// // class _MessageDetailPageState extends State<MessageDetailPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Padding(
// //         padding: EdgeInsets.all(10.0),
// //         child: Column(
// //           //  crossAxisAlignment:
// //           //    CrossAxisAlignment.center, // Align text to the start
// //           children: [
// //             const SizedBox(height: 60,),
// //             CircleAvatar(
// //               radius: 50, // Adjust the size as needed
// //               backgroundImage: NetworkImage(widget.message.profilePicUrl), // Use NetworkImage for URLs
// //               // Or use AssetImage for local assets
// //               // backgroundImage: AssetImage(widget.message.profilePicUrl),
// //             ),
// //             SizedBox(height: 10),
// //             Center(
// //               child: Text(
// //                 widget.message.username,
// //                 style: CustomTextStyle.titleText.copyWith(
// //                     color: Color.fromARGB(255, 0, 0, 0),
// //                     fontSize: responsiveSize(context, 0.05)),
// //               ),
// //             ),
// //              SizedBox(
// //                 height:
// //                     10),
// //                     Text('You are both mutuals on this app',
// //                     style: CustomTextStyle.LightText.copyWith(color: Color.fromARGB(255, 0, 0, 0),
// //                     fontSize: responsiveSize(context, 0.03))),
// //             SizedBox(
// //                 height:
// //                     10), // Add some space between the username and the message content
// //             Text(widget.message.content),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class MessageDetailPage extends StatefulWidget {
//   final Message message;

//   const MessageDetailPage({Key? key, required this.message}) : super(key: key);

//   @override
//   _MessageDetailPageState createState() => _MessageDetailPageState();
// }

// class _MessageDetailPageState extends State<MessageDetailPage> {
//   final TextEditingController _messageController = TextEditingController();

// //  @override
// //  Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Padding(
// //         padding: EdgeInsets.all(10.0),
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 60,),
// //             CircleAvatar(
// //               radius: 50, // Adjust the size as needed
// //               backgroundImage: NetworkImage(widget.message.profilePicUrl), // Use NetworkImage for URLs
// //             ),
// //             SizedBox(height: 10),
// //             Center(
// //               child: Text(
// //                 widget.message.username,
// //                 style: CustomTextStyle.titleText.copyWith(
// //                     color: Color.fromARGB(255, 0, 0, 0),
// //                     fontSize: responsiveSize(context, 0.05)),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Text('You are both mutuals on this app',
// //                 style: CustomTextStyle.LightText.copyWith(color: Color.fromARGB(255, 0, 0, 0),
// //                 fontSize: responsiveSize(context, 0.03))),
// //             SizedBox(height: 10), // Add some space between the username and the message content
// //             Text(widget.message.content),
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                 child: TextField(
// //                  controller: _messageController,
// //                  decoration: InputDecoration(
// //                     hintText: 'Type your message here...',
// //                     suffixIcon: IconButton(
// //                       icon: Icon(Icons.send),
// //                       onPressed: () {
// //                         // Handle send message logic here
// //                         print(_messageController.text);
// //                         _messageController.clear();
// //                       },
// //                     ),
// //                  ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //  }
// // }
// // @override
// //  Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Padding(
// //         padding: EdgeInsets.all(10.0),
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 60,),
// //             CircleAvatar(
// //               radius: 50, // Adjust the size as needed
// //               backgroundImage: NetworkImage(widget.message.profilePicUrl), // Use NetworkImage for URLs
// //             ),
// //             SizedBox(height: 10),
// //             Center(
// //               child: Text(
// //                 widget.message.username,
// //                 style: CustomTextStyle.titleText.copyWith(
// //                     color: Color.fromARGB(255, 0, 0, 0),
// //                     fontSize: responsiveSize(context, 0.05)),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Text('You are both mutuals on this app',
// //                 style: CustomTextStyle.LightText.copyWith(color: Color.fromARGB(255, 0, 0, 0),
// //                 fontSize: responsiveSize(context, 0.03))),
// //             SizedBox(height: 10), // Add some space between the username and the message content
// //            Padding(
// //             padding: const EdgeInsets.all(10),
// //             child: Row(
// //               children: [
// //                 CircleAvatar(
// //                  radius: 20, // Adjust the size as needed
// //                  backgroundImage: NetworkImage(widget.message.profilePicUrl), // Use NetworkImage for URLs
// //                 ),
// //                 SizedBox(width: 10), // Add some space between the avatar and the message box
// //                 Expanded(
// //                  child: Container(
// //                     padding: EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey[200], // Change the color as needed
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Text(
// //                       widget.message.content,
// //                       style: TextStyle(color: Colors.black), // Adjust the text style as needed
// //                     ),
// //                  ),
// //                 ),
// //               ],
// //             ),
// //            ),
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
// //                 child: TextField(
// //                  controller: _messageController,
// //                  decoration: InputDecoration(
// //                     hintText: 'Type your message here...',
// //                     suffixIcon: IconButton(
// //                       icon: const Icon(Icons.send),
// //                       onPressed: () {
// //                         // Handle send message logic here
// //                         print(_messageController.text);
// //                         _messageController.clear();
// //                       },
// //                     ),
// //                  ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //  }
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   CircleAvatar(
//                     radius: 50, // Adjust the size as needed
//                     backgroundImage: NetworkImage(widget
//                         .message.profilePicUrl), // Use NetworkImage for URLs
//                   ),
//                   SizedBox(height: 10),
//                   Center(
//                     child: Text(
//                       widget.message.username,
//                       style: CustomTextStyle.titleText.copyWith(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontSize: responsiveSize(context, 0.05)),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text('You are both mutuals on this app',
//                       style: CustomTextStyle.LightText.copyWith(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontSize: responsiveSize(context, 0.03))),
//                   SizedBox(
//                       height:
//                           10), // Add some space between the username and the message content
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 20, // Adjust the size as needed
//                           backgroundImage: NetworkImage(widget.message
//                               .profilePicUrl), // Use NetworkImage for URLs
//                         ),
//                         SizedBox(
//                             width:
//                                 10), // Add some space between the avatar and the message box
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .grey[200], // Change the color as needed
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               widget.message.content,
//                               style: TextStyle(
//                                   color: Colors
//                                       .black), // Adjust the text style as needed
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Add more messages here
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: TextField(
//                 controller: _messageController,
//                 decoration: InputDecoration(
//                   hintText: 'Type your message here...',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () {
//                       // Handle send message logic here
//                       print(_messageController.text);
//                       _messageController.clear();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
