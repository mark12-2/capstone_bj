import 'package:capstone/default_screens/employer_jobpost_view.dart';
import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/screens_for_auth/edit_user_information.dart';
import 'package:capstone/screens_for_auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userLoggedIn = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("FlutterPhone Auth"),
        actions: [
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
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            backgroundImage:
                NetworkImage(userLoggedIn.userModel.profilePic ?? 'null'),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(userLoggedIn.userModel.name),
          Text(userLoggedIn.userModel.phoneNumber),
          Text(userLoggedIn.userModel.email ?? 'null'),
          Text(userLoggedIn.userModel.birthdate),
          Text(userLoggedIn.userModel.address),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditUserInformation(),
                ),
              );
            },
            child: const Text("Edit Profile"),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text(
                        'Are you sure you want to delete your account? This action cannot be undone.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () async {
                          await userLoggedIn
                              .deleteUserFromFirestore(userLoggedIn.uid);
                          await userLoggedIn.userSignOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Delete My Account'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerJobpostView(),
                ),
              );
            },
            child: const Text("view post"),
          ),
        ],
      )),
    );
  }
}
