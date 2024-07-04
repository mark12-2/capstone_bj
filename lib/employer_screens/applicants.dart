import 'package:capstone/default_screens/view_profile.dart';
import 'package:capstone/provider/posts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplicantsPage extends StatefulWidget {
  final String jobId;

  const ApplicantsPage({super.key, required this.jobId});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  final PostsProvider _postsProvider = PostsProvider();
  late Stream<QuerySnapshot> _applicantsStream;

  @override
  void initState() {
    super.initState();
    _applicantsStream = _postsProvider.getApplicantsStream(widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _applicantsStream,
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
              child: Text("No applicants"),
            );
          }

          final applicants = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: applicants.length,
                  itemBuilder: (context, index) {
                    final applicant = applicants[index];

                    String applicantName = applicant['applicantName'];
                    String applicantPhone = applicant['applicantPhone'];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(applicantName),
                          subtitle: Text(applicantPhone),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Hire button
                              _hireApplicant(applicant);
                            },
                            child: Text('Hire'),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                    userId: applicant['idOfApplicant']),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _hireApplicant(dynamic applicant) {
    // Implement hiring logic here
    print('Hiring ${applicant['applicantName']}');
  }

  void _deleteApplicant(dynamic applicant) {
    // Implement deleting logic here
    print('Deleting ${applicant['applicantName']}');
  }
}
