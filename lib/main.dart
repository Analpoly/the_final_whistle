import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_final_whistle/firebase_options.dart';
// import 'package:the_final_whistle/login.dart';
import 'package:the_final_whistle/matches.dart';
import 'package:the_final_whistle/splash.dart';

// import 'package:flutter/material.dart';
// import 'package:your_project_name/splash_screen.dart'; // Assuming your splash screen is in a file named splash_screen.dart
// import 'package:your_project_name/home_screen.dart'; // Assuming your home screen is in a file named home_screen.dart

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title', // Replace with your app title
      routes: {
        '/': (context) => SplashScreen(), // Map '/' route to SplashScreen
        '/home': (context) => Dark7(), // Map '/home' route to HomeScreen
      },
    );
  }
}

