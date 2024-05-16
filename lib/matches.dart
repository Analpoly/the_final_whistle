import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_final_whistle/leagues.dart';

// class Dark2 extends StatefulWidget {
//   Dark2({Key? key}) : super(key: key);

//   @override
//   _Dark2State createState() => _Dark2State();
// }

// class _Dark2State extends State<Dark2> {
//   final _formKey = GlobalKey<FormState>();
//   final abc = TextEditingController();
//   final def = TextEditingController();
//   final ghi = TextEditingController();
//   final mno = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Student Database"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey, // Associate the GlobalKey with the Form
//           child: ListView(
//             children: [
//               Icon(Icons.face, size: 80),
//               SizedBox(height: 25),
//               TextFormField(
//                 controller: abc,
//                 decoration: InputDecoration(
//                   labelText: "User name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a user name.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 25),
//              TextField(
//   controller: def,
//   decoration: InputDecoration(
//     labelText: 'Phone Number',
//     prefixText: '+91 ',
//     border: OutlineInputBorder(),
//   ),
//   keyboardType: TextInputType.numberWithOptions(
//     signed: false,
//     decimal: false,
//   ),
//   inputFormatters: [
//     // Ensures that only 10 digits can be entered
//     LengthLimitingTextInputFormatter(10),
//   ],
// ),
//               SizedBox(height: 25),
//               TextFormField(
//                 controller: ghi,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: "Email Address",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter an email address.';
//                   }
//                   if (!isEmail(value)) {
//                     return 'Please enter a valid email address.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 25),
//               TextFormField(
//                 controller: mno,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a password.';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters long.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _register();
//                 },
//                 child: Text("Register"),
//               ),
//               SizedBox(height: 30),
//                           Text(" Already have an account?"),

//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => Dark7()),
//                   );
//                 },
//                 child: Text("Login"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _register() {
//     if (_formKey.currentState!.validate()) {
//       final profile = ProfileModel(
//         Username: abc.text,
//         mobile: int.tryParse(def.text) ?? 0,
//         Email: ghi.text,
//         Password: mno.text,
//         key: null,
//       );

//       abc.clear();
//       def.clear();
//       ghi.clear();
//       mno.clear();

//       ProfileDatabase().sendData(profile).then((_) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyWidget2()),
//         );
//       });
//     }
//   }

//   bool isNumeric(String value) {
//     if (value == null) {
//       return false;
//     }
//     return double.tryParse(value) != null;
//   }

//   bool isEmail(String value) {
//     String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b';
//     RegExp regExp = new RegExp(pattern);
//     return regExp.hasMatch(value);
//   }
// }
// yoo

import 'package:the_final_whistle/login.dart';


void main() {
  runApp(MaterialApp(
    home: Dark7(),
  ));
}


class Dark2 extends StatefulWidget {
  Dark2({Key? key}) : super(key: key);

  @override
  _Dark2State createState() => _Dark2State();
}

class _Dark2State extends State<Dark2> {
  final _formKey = GlobalKey<FormState>();
  final abc = TextEditingController();
  final ghi = TextEditingController();
  final mno = TextEditingController();
  late SharedPreferences _prefs;
bool _isPasswordVisible = false;


  @override
   void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // If already logged in, navigate to MyWidget2
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyWidget2()),
      );
    }
  }

  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
    // Exit the app when the back button is pressed
    SystemNavigator.pop();
    return false; // Prevent back navigation
  },
    child:  Scaffold(

    backgroundColor: Color.fromARGB(255, 44, 43, 48), // Navy blue background color

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
                Padding(
        padding: const EdgeInsets.fromLTRB(20, 120, 16, 8), // Adjusted padding

        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),      SizedBox(height: 10,),

              TextFormField(
                controller: abc,
                                style: TextStyle(color: Colors.white), // Color of the text entered by the user

                decoration: InputDecoration(
                  labelText: "User name",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a user name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: ghi,
                                style: TextStyle(color: Colors.white), // Color of the text entered by the user

                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Address",
                 labelStyle: TextStyle(color: Colors.white),

                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email address.';
                  }
                  if (!isEmail(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
            TextFormField(
  controller: mno,
  obscureText: !_isPasswordVisible, // Toggle obscureText based on _isPasswordVisible
  style: TextStyle(color: Colors.white),
  decoration: InputDecoration(
    labelText: "Password",
                     labelStyle: TextStyle(color: Colors.white),

    border: OutlineInputBorder(),
    suffixIcon: IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.white,
      ),
      onPressed: () {
        // Toggle the visibility of the password
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  },
),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text("Register"),
              ),
              SizedBox(height: 80),
              Row(
                children: [
                  Text(" Already have an account?",style: TextStyle(color: Colors.white),),
                
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dark7()),
                  );
                },
                child: Text("Log in",style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        ]),
      ),
    )));
  }

 void _register() {
  if (_formKey.currentState!.validate()) {
    final profile = ProfileModel(
      Username: abc.text,
      Email: ghi.text,
      Password: mno.text,
      key: null,
    );

    // Check if the username already exists
    ProfileDatabase().getData().then((profiles) {
      if (profiles.any((profile) => profile.Username == abc.text)) {
        // Username already exists, show an error message
        _showErrorDialog(context, 'Username already exists. Please choose a different one.');
      } else {
        // Username is unique, proceed with registration
        abc.clear();
        ghi.clear();
        mno.clear();

        ProfileDatabase().sendData(profile).then((_) {
          // Set shared preference for registration status
          _setRegistrationStatus(true).then((_) {
            // Show snackbar indicating successful registration
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration Successful'),
                duration: Duration(seconds: 2), // Adjust duration as needed
              ),
            );
            // Navigate to MyWidget2 after a delay to allow time for the snackbar to be shown
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyWidget2()),
                
              );
            });
          });
        });
      }
    });
  }
}

  Future<void> _setRegistrationStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }


  bool isEmail(String value) {
    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  // void _proceedWithPhoneNumber() {
  //   String phoneNumber = phoneNumberController.text.trim();
  //   if (phoneNumber.isEmpty) {
  //     _showErrorDialog(context, 'Please enter your phone number');
  //   } else if (phoneNumber.length != 10) {
  //     _showErrorDialog(context, 'Please enter a valid 10-digit phone number');
  //   } else {
  //     // Add the prefix "+91" to the phone number
  //     phoneNumber = "+91$phoneNumber";
  //     _verifyPhoneNumber(context, phoneNumber);
  //   }
  // }

  // Future<void> _verifyPhoneNumber(BuildContext context, String phoneNumber) async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => Dark2()),
  //         );
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         _showErrorDialog(context, 'Failed to verify phone number: ${e.message}');
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         await _showOtpDialog(context, verificationId);
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Auto-retrieve timeout, handle if needed
  //       },
  //     );
  //   } catch (e) {
  //     _showErrorDialog(context, 'Failed to verify phone number: $e');
  //   }
  // }

  // void _verifyOTP() {
  //   String otp = smsCodeController.text.trim();
  //   if (otp.isEmpty) {
  //     _showErrorDialog(context, 'Please enter the OTP');
  //   } else if (otp.length != 6) {
  //     _showErrorDialog(context, 'Please enter a valid 6-digit OTP');
  //   } else {
  //     // Proceed with OTP verification logic
  //     // You can implement this logic similar to how you have implemented in your _showOtpDialog method
  //   }
  // }

  // Future<void> _showOtpDialog(BuildContext context, String verificationId) async {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter OTP'),
  //         content: TextField(
  //           controller: smsCodeController,
  //           keyboardType: TextInputType.number,
  //           inputFormatters: [
  //             // Ensures that only 6 digits can be entered
  //             LengthLimitingTextInputFormatter(6),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               String otp = smsCodeController.text.trim();
  //               if (otp.isEmpty) {
  //                 _showErrorDialog(context, 'Please enter the OTP');
  //               } else if (otp.length != 6) {
  //                 _showErrorDialog(context, 'Please enter a valid 6-digit OTP');
  //               } else {
  //                 try {
  //                   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
  //                   await _auth.signInWithCredential(credential);
  //                   Navigator.pop(context); // Close the OTP dialog
  //                 } catch (e) {
  //                   print('Failed to sign in with phone number: $e');
  //                 }
  //               }
  //             },
  //             child: Text('Submit'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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

class Dark7 extends StatefulWidget {
  const Dark7({Key? key}) : super(key: key);

  @override
  State<Dark7> createState() => _Dark7State();
}

class _Dark7State extends State<Dark7> {
  TextEditingController _abc = TextEditingController();
  TextEditingController _xyz = TextEditingController();
  late SharedPreferences _prefs;
  final _formKey = GlobalKey<FormState>();
bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // If already logged in, navigate to MyWidget2
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyWidget2()),
      );
    }
  }

 Future<void> signIn() async {
  String enteredUsername = _abc.text.trim();
  String enteredPassword = _xyz.text.trim();

  try {
    ProfileModel? profile = await ProfileDatabase().fetch(enteredUsername);

    if (profile != null && profile.Password == enteredPassword) {
      // If username and password are correct, set isLoggedIn to true
      // and navigate to MyWidget2
      await _prefs.setBool('isLoggedIn', true);
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyWidget2()),
      
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid username or password")),
      );
    }
  } catch (e) {
    print("Failed to login: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to login: $e")),
    );
  }
}


  Future<void> forgotPassword() async {
    String enteredUsername = _abc.text.trim(); // Assuming username is email here

    try {
      // Assume ProfileDatabase() contains fetch method to retrieve user profile
      ProfileModel? profile = await ProfileDatabase().fetch(enteredUsername);

      if (profile != null) {
        // Send password reset link or verification code to user's email
        // Here you can implement your logic to send an email to the user
        // containing a password reset link or verification code

        // After sending the email, navigate to the screen where users can
        // enter the verification code or follow the reset link to set a new password
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen(profile: profile)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found. Please enter a valid Username.")),
        );
      }
    } catch (e) {
      print("Failed to initiate password reset: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to initiate password reset: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
    // backgroundColor: Color.fromARGB(255, 35, 23, 92), // Navy blue background color
        backgroundColor: Color.fromARGB(255, 44, 43, 48), // Navy blue background color

      body: ListView(
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 120, 16, 8), // Adjusted padding

        child: Text(
          "Log in",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 10,),
       Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _abc,
                                style: TextStyle(color: Colors.white), // Color of the text entered by the user

                decoration: InputDecoration(labelStyle: TextStyle(color: Colors.white),

                  labelText: "Username",
                   border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Set the border color here
    ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
             TextFormField(
  controller: _xyz,
  obscureText: !_isPasswordVisible, // Toggle obscureText based on _isPasswordVisible
  style: TextStyle(color: Colors.white),
  decoration: InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    labelText: "Password",
    border: OutlineInputBorder(),
    suffixIcon: IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.white,
      ),
      onPressed: () {
        // Toggle the visibility of the password
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  },
),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signIn();
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: forgotPassword,
                child: Text("Forgot Password?",style: TextStyle(color: Colors.red),),
              ),
                SizedBox(height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp1()),
                        );
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],)))]));
  }
}

// class ProfileModel {
//   String Password;

//   ProfileModel({required this.Password});
// }

// class ProfileDatabase {
//   void updatePassword(ProfileModel profile) {
//     // Your implementation to update password in the database
//     print('Password updated: ${profile.Password}');
//   }
// }

class ResetPasswordScreen extends StatelessWidget {
  final ProfileModel profile;
  final _formKey = GlobalKey<FormState>(); // GlobalKey to access FormState

  ResetPasswordScreen({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _newPasswordController = TextEditingController();

    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 35, 23, 92),
          backgroundColor: Color.fromARGB(255, 44, 43, 48), // Navy blue background color

      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Assign the GlobalKey to the Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _newPasswordController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Update password in the database
                    profile.Password = _newPasswordController.text.trim();
                    ProfileDatabase().updatePassword(profile);

                    // Optionally, you can navigate back to the login screen
                    Navigator.pop(context);
                  }
                },
                child: Text("Set New Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProfileModel {
  ProfileModel({
    this.Username,
    this.Email,
    this.Password,
    this.key,
  });
  String? Username;
  String? Email;
  String? Password;
  String? key;
  Map<String, dynamic> toMap() {
    return {
      "name": Username,
      "email": Email,
      "password": Password,
    };
  }
}

class ProfileDatabase {
  DatabaseReference database() {
    return FirebaseDatabase.instance.ref().child("Profile Database");
  }

  Future<void> sendData(ProfileModel profile) async {
    try {
      final key = database().push().key!;

      await database().child(key).set(profile.toMap());
      print("Data added successfully with key: $key");
    } catch (error) {
      print("Error adding data: $error");
    }
  }

  Future<List<ProfileModel>> getData() async {
    var db = await FirebaseDatabase.instance.ref().child("Profile Database").once();
    if (db.snapshot.value != null) {
      Map<dynamic, dynamic> items = db.snapshot.value as Map<dynamic, dynamic>;
      List<ProfileModel> profiles = [];
      items.forEach((key, value) {
        profiles.add(ProfileModel(
          key: key,
          Username: value["name"],
          Email: value["email"],
          Password: value["password"],
        ));
      });
      return profiles;
    } else {
      return [];
    }
  }

  Future<void> updatePassword(ProfileModel profile) async {
    try {
      await database().child(profile.key!).update({"password": profile.Password});
      print("Password updated successfully for user: ${profile.Username}");
    } catch (error) {
      print("Error updating password: $error");
    }
  }

  Future<ProfileModel?> fetch(String username) async {
    List<ProfileModel> profiles = await getData();
    ProfileModel? profile;
    try {
      profile = profiles.firstWhere(
        (profile) => profile.Username == username,
      );
    } catch (e) {
      print("User not found with username: $username");
    }
    return profile;
  }
}
