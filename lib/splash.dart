import 'package:flutter/material.dart';
import 'dart:async'; // Import dart:async for Timer

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/home')); // Navigate to '/home' route

    return Scaffold(
      body: Center(
        child: Container(
          // Set container to fill the entire screen
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'images/spl.png', // Replace with your image path
            fit: BoxFit.cover, // Use cover to fill the entire container
          ),
        ),
      ),
    );
  }
}
