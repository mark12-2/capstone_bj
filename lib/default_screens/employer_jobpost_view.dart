import 'package:capstone/mapping/location_service.dart';
import 'package:capstone/provider/jobpost_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class EmployerJobpostView extends StatefulWidget {
  const EmployerJobpostView({super.key});

  @override
  State<EmployerJobpostView> createState() => _EmployerJobpostViewState();
}

class _EmployerJobpostViewState extends State<EmployerJobpostView> {
  final JobPostProvider jobpostdetails = JobPostProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetching post"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: jobpostdetails.getJobPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final jobPosts = snapshot.data!.docs;

          return Expanded(
              child: ListView.builder(
                  itemCount: jobPosts.length,
                  itemBuilder: (context, index) {
                    final jobpost = jobPosts[index];

                    String name = jobpost['name'];
                    String email = jobpost['email'];
                    String role = jobpost['role'];
                    String profilePic = jobpost['profilePic'];
                    String title = jobpost['title'];
                    String description = jobpost['description'];
                    String type = jobpost['type'];
                    String location = jobpost['location'];
                    String rate = jobpost['rate'];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profilePic),
                        ),
                        title: Text(title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Posted by: $name ($role)"),
                            Text("Email: $email"),
                            Text("Type: $type"),
                            Text("Rate: $rate"),
                            Text(description),
                            Row(
                              children: [
                                Text("Location: "),
                                GestureDetector(
                                  onTap: () async {
                                    final locations = await locationFromAddress(location);
                                    final lat = locations[0].latitude;
                                    final lon = locations[0].longitude;
                                    showLocationPickerModal(context, TextEditingController(text: '$lat, $lon'));
                                  },
                                  child: Text(location, style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
        },
      ),
    );
  }
}