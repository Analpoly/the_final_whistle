import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:the_final_whistle/matches.dart'; // Add this import for TextInputType.numberWithOptions

class MyApp1 extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 35, 23, 92), // Navy blue background color
    backgroundColor: Color.fromARGB(255, 44, 43, 48), // Navy blue background color

      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/spl.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,color: Colors.white70
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
            TextField(
  controller: phoneNumberController,
                  style: TextStyle(color: Colors.white), // Color of the text entered by the user

  decoration: InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    labelText: 'Phone Number',
    prefixText: '+91 ',    prefixStyle: TextStyle(color: Colors.white), // Color of the prefix text

    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.numberWithOptions(
    signed: false,
    decimal: false,
  ),
  inputFormatters: [
    // Ensures that only 10 digits can be entered
    LengthLimitingTextInputFormatter(10),
  ],
),

              SizedBox(height: 20),
            ElevatedButton(
  onPressed: () async {
    String phoneNumber = phoneNumberController.text.trim();
    if (phoneNumber.isEmpty) {
      _showErrorDialog(context, 'Please enter your phone number');
    } else if (phoneNumber.length != 10) {
      _showErrorDialog(context, 'Please enter a valid 10-digit phone number');
    } else {
      // Add the prefix "+91" to the phone number
      phoneNumber = "+91$phoneNumber";
      await _verifyPhoneNumber(context, phoneNumber);
    }
  },
  child: Text('Login'),
),

            ],
          ),
        ],
      ),
    );
  }

  Future<void> _verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dark2()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          _showErrorDialog(context, 'Failed to verify phone number: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          await _showOtpDialog(context, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieve timeout, handle if needed
        },
      );
    } catch (e) {
      _showErrorDialog(context, 'Failed to verify phone number: $e');
    }
  }

 Future<void> _showOtpDialog(BuildContext context, String verificationId) async {
  TextEditingController otpController = TextEditingController();
  
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter OTP'),
        content: TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Ensure only digits are allowed
            LengthLimitingTextInputFormatter(6), // Limit input to 6 characters
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              String otp = otpController.text.trim();
              
              // Check if OTP is empty
              if (otp.isEmpty) {
                _showErrorDialog(context, 'Please enter the OTP');
              }
              // Check if OTP is not exactly 6 digits
              else if (otp.length != 6) {
                _showErrorDialog(context, 'Please enter a valid 6-digit OTP');
              }
              else {
                try {
                  // Proceed with OTP verification
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
                  final authResult = await _auth.signInWithCredential(credential);
                  if (authResult.user != null) {
                    // OTP is correct, proceed to next screen
                    Navigator.pop(context); // Close the OTP dialog
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dark2()),);
                  } else {
                    // OTP is incorrect
                    _showErrorDialog(context, 'Incorrect OTP. Please try again.');
                  }
                } catch (e) {
                  print('Failed to sign in with phone number: $e');
                  // Handle specific error when OTP is incorrect
                  if (e.hashCode == 'invalid-verification-code') {
                    _showErrorDialog(context, 'Incorrect OTP. Please try again.');
                  } else {
                    // Handle other authentication errors
                    _showErrorDialog(context, 'Failed to verify OTP. Please try again.');
                  }
                }
              }
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}




  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}