import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libapp/loginscreen.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  bool isPasswordVisible = false;
  bool isTextFieldFocused = false;
  Color customButtonColor = const Color(0xFF5DDFBC);
  Color signUpColor = const Color(0xFF34A853);
  Color forgotPasswordColor = const Color(0xFF164B60);



  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    final String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text('Check your email to reset your password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle password reset errors (e.g., user not found, invalid email, etc.)
      print('Error sending password reset email: $e');
      // You can display an error message to the user here.
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        // Background Image
        Image.asset(
        'assets/images/newlogin.png', // Replace with the actual path to your image asset
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const SizedBox(height: 80),
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9796A1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0,),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your E-Mail',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF9796A1),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff164B60),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: const TextStyle(color: Color(0xff9796A1),),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Center(
                  child: Container(
                    width: 180,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF55B799), Color(0xFF5DDFBC)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: TextButton(
                      onPressed: _resetPassword,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Get Link',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:80),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Need to go back? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: signUpColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      ],
      ),
    );
  }
}
