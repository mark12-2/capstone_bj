import 'package:capstone/chats/messaging_roompage.dart';
import 'package:capstone/default_screens/comment.dart';
import 'package:capstone/provider/mapping/location_service.dart';
import 'package:capstone/provider/notifications/notifications_provider.dart';
import 'package:capstone/provider/posts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone/default_screens/notification.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final _commentTextController = TextEditingController();
  bool _isApplied = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showCommentDialog(String postId, BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => CommentScreen(postId: postId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PostsProvider postDetails = Provider.of<PostsProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 74, 109),
        leading: GestureDetector(
          onTap: () {
            _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
          child: Image.asset('assets/images/bluejobs.png'),
        ),
        actions: <Widget>[
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              return Stack(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (notificationProvider.unreadNotifications > 0) {
                        notificationProvider.markAsRead();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsPage(),
                        ),
                      );
                    },
                  ),
                  if (notificationProvider.unreadNotifications > 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: postDetails.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No posts available"),
                  );
                }

                final posts = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      String name = post['name'];
                      String userId = post['ownerId'];
                      String role = post['role'];
                      String profilePic = post['profilePic'];
                      String title = post['title']; // for job post
                      String description = post['description'];
                      String type = post['type'];
                      String location = post['location']; // for job post
                      String rate = post['rate'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 4.0,
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(profilePic),
                                      radius: 35.0,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SimpleDialog(
                                                      children: [
                                                        SimpleDialogOption(
                                                          child: const Text(
                                                              'View Profile'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        //
                                                        SimpleDialogOption(
                                                          child: const Text(
                                                              'Send Message'),
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MessagingBubblePage(
                                                                  receiverName:
                                                                      name,
                                                                  receiverId:
                                                                      userId,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ));
                                          },
                                          child: Text(
                                            "$name",
                                            style: CustomTextStyle.semiBoldText
                                                .copyWith(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize:
                                                  responsiveSize(context, 0.05),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "$role",
                                          style:
                                              CustomTextStyle.roleRegularText,
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                const SizedBox(height: 15),
                                // post description
                                role == 'Employer'
                                    ? Text(
                                        "$title",
                                        style: CustomTextStyle.semiBoldText,
                                      )
                                    : Container(), // return empty 'title belongs to employer'

                                const SizedBox(height: 5),

                                Text(
                                  "$description",
                                  style: CustomTextStyle.regularText,
                                ),

                                const SizedBox(height: 15),

                                role == 'Employer'
                                    ? Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final locations =
                                                  await locationFromAddress(
                                                      location);
                                              final lat = locations[0].latitude;
                                              final lon =
                                                  locations[0].longitude;
                                              showLocationPickerModal(
                                                  context,
                                                  TextEditingController(
                                                      text: '$lat, $lon'));
                                            },
                                            child: Text(
                                                "$location (tap to view location)",
                                                style: const TextStyle(
                                                    color: Colors.blue)),
                                          ),
                                        ],
                                      )
                                    : Container(),

                                Text(
                                  "Type of Job: $type",
                                  style: CustomTextStyle.typeRegularText,
                                ),
                                Text(
                                  "Rate: $rate",
                                  style: CustomTextStyle.regularText,
                                ),

                                const SizedBox(height: 20),

                                // comment section
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showCommentDialog(post.id, context);
                                      },
                                      child: Container(
                                        height: 53,
                                        width: 185,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 7, 30, 47),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Comment',
                                            style: CustomTextStyle.regularText
                                                .copyWith(
                                              color: Colors.white,
                                              fontSize:
                                                  responsiveSize(context, 0.03),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),
                                    userId == auth.currentUser!.uid
                                        ? Container()
                                        : role == 'Employer'
                                            ? InkWell(
                                                child: GestureDetector(
                                                  onTap: _isApplied
                                                      ? null
                                                      : () async {
                                                          final notificationProvider =
                                                              Provider.of<
                                                                      NotificationProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          String receiverId =
                                                              userId; // Get the receiver's ID
                                                          await notificationProvider
                                                              .jobApplicationNotification(
                                                            receiverId:
                                                                receiverId,
                                                            senderId: auth
                                                                .currentUser!
                                                                .uid,
                                                            senderName: auth
                                                                    .currentUser!
                                                                    .displayName ??
                                                                'Unknown',
                                                            notif:
                                                                ', applied to your job entitled "$title"',
                                                          );
                                                          setState(() {
                                                            _isApplied = true;
                                                          });
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Successfully applied')),
                                                          );
                                                        },
                                                  child: Container(
                                                    height: 53,
                                                    width: 180,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: _isApplied
                                                            ? Colors.grey
                                                            : Colors.orange,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        _isApplied
                                                            ? 'Applied'
                                                            : 'Apply Job',
                                                        style: CustomTextStyle
                                                            .regularText
                                                            .copyWith(
                                                          color: _isApplied
                                                              ? Colors.grey
                                                              : const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                          fontSize:
                                                              responsiveSize(
                                                                  context,
                                                                  0.03),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(), // return empty container if role is not 'Employer'
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
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
}
