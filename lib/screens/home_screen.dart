import 'package:capstone/provider/auth_provider.dart';
import 'package:capstone/screens/signin.dart';
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
            backgroundImage: NetworkImage(userLoggedIn.userModel.profilePic),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(userLoggedIn.userModel.name),
          Text(userLoggedIn.userModel.phoneNumber),
          Text(userLoggedIn.userModel.email),
          Text(userLoggedIn.userModel.birthdate),          
          Text(userLoggedIn.userModel.address),
        ],
      )),
    );
  }
}
