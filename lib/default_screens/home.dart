import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/screens_for_auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:capstone/default_screens/notification.dart';
import 'package:capstone/styles/textstyle.dart';
import 'package:capstone/styles/responsive_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  bool _showCommentInput = false;
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userLoggedIn = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
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
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()),
                );
              },
            ),
            // temporary sign out (should be in profile section)
            IconButton(
              onPressed: () {
                userLoggedIn.userSignOut().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ]),
          // post lists - from employer or job hunter
          
    




















      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            15.0, 20.0, 15.0, 20.0), 
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation:
                      4.0, 
                  margin: const EdgeInsets.fromLTRB(
                      0.0, 10.0, 0.0, 10.0), 
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                                // add avatar
                                ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Employer',
                              style: //CustomTextStyle.semiBoldText
                                  CustomTextStyle.semiBoldText.copyWith(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: responsiveSize(context, 0.05)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hi I am looking for a plumber who can work for me. Will work mainly on leaking pipes on the sink. 500 pesos would be the payment.',
                          style: CustomTextStyle.regularText,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Handle button press
                              },
                              child: Container(
                                height: 53,
                                width: 165, // Adjust width as needed
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                      255, 7, 30, 47), // Background color
                                  borderRadius:
                                      BorderRadius.circular(5), // Border radius
                                ),
                                child: Center(
                                  child: Text(
                                    'Apply Now',
                                    style: CustomTextStyle.regularText.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            responsiveSize(context, 0.03)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), // Space between buttons
                            InkWell(
                              onTap: () {
                                // Handle button press
                              },
                              child: Container(
                                height: 53,
                                width: 165, // Adjust width as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.orange, // Border color
                                    width: 2, // Border width
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(5), // Border radius
                                  color: Colors.white, // Background
                                ),
                                child: Center(
                                  child: Text(
                                    'Save for Later',
                                    // style: TextStyle(
                                    //   color: Color.fromARGB(
                                    //       255, 0, 0, 0), // Text color
                                    //   fontSize: 16,
                                    style: CustomTextStyle.regularText.copyWith(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize:
                                            responsiveSize(context, 0.03)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),







                // Add more cards here as needed
                Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation:
                      4.0, // Add a slight shadow for better card separation
                  margin: const EdgeInsets.fromLTRB(
                      0.0, 10.0, 0.0, 10.0), // Remove margin for inner padding
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                                // add avatar
                                // radius: 40,
                                ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'User',
                              style: //CustomTextStyle.semiBoldText
                                  CustomTextStyle.regularText.copyWith(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: responsiveSize(context, 0.04)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hi I am looking for work. 500 pesos would be the payment.',
                          style: CustomTextStyle.regularText,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up_alt_rounded),
                              onPressed: () {
                                // Add logic for liking the post
                              },
                            ),
                            const Text(
                              'React',
                              style: CustomTextStyle.regularText,
                            ),
                            const SizedBox(width: 85),
                            InkWell(
                              onTap: () {
                                // Toggle visibility of comment input field and post button
                                setState(() {
                                  _showCommentInput = !_showCommentInput;
                                });
                              },
                              child: const Text(
                                'Comment',
                                style: CustomTextStyle.regularText,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _showCommentInput,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align items at the start of the cross axis
                            children: [
                              Expanded(
                                child: Container(
                                  height: 53,
                                  child: TextFormField(
                                    controller:
                                        _commentController, // Define a TextEditingController
                                    decoration: const InputDecoration(
                                      hintText: 'Write your comment...',
                                      hintStyle: CustomTextStyle.regularText,
                                      border: OutlineInputBorder(),
                                    ),
                                    minLines: 1,
                                    maxLines: 3,
                                    textAlignVertical: TextAlignVertical.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 53, // Set the height of the container
                                width: 70,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 7, 30,
                                      47), // Set the background color to blue
                                  borderRadius: BorderRadius.circular(
                                      5), // Set the border radius to 5
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Add logic for posting the comment
                                    // String commentText = _commentController.text;
                                    // Process the commentText (e.g., post it, clear the input field, etc.)
                                    // Clear the input field
                                    _commentController.clear();
                                    // Hide the comment input field and post button after posting the comment
                                    setState(() {
                                      _showCommentInput = false;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Post',
                                      // style: TextStyle(
                                      //   color: Colors.white, // Set the text color to white
                                      //   fontSize: 16, // Adjust font size as needed
                                      // ),
                                      style: CustomTextStyle.regularText
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
