import 'package:capstone/firebase_options.dart';
import 'package:capstone/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:capstone/screens/signin.dart';
import 'package:provider/provider.dart';

// firebase connection 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ThisApp());
}

class ThisApp extends StatelessWidget {
  const ThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Blue Jobs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInPage(),
      ),
    );
  }
}

//Flutter Routing Map Leaflet
//Flutter Firebase Phone Auth Tutorial For Beginners | Firestore, Firebase Storage, Auth (Latest)
//keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 
