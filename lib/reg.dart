import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Image background
            Image(
              image: AssetImage('images/spl.png'),
              fit: BoxFit.cover, // Adjust to cover the entire screen
              width: MediaQuery.of(context).size.width, // Set width to screen width
              height: MediaQuery.of(context).size.height, // Set height to screen height
            ),
            // Registration details container
            Positioned(
              top: 50.0, // Adjust top padding
              left: 20.0, // Adjust left padding
              right: 20.0, // Adjust right padding (optional)
              bottom: 150.0, // Adjust bottom padding (optional)
              child: Container(
                padding: EdgeInsets.all(20.0), // Inner padding for registration fields
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 10.0), // Add spacing between fields
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true, // For password input
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle registration form submission logic
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
