import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginscreen.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isPasswordVisible = false;
  bool isTextFieldFocused = false;
  Color customButtonColor = const Color(0xFF5DDFBC);
  Color signUpColor = const Color(0xFF34A853);
  Color forgotPasswordColor = const Color(0xFF164B60);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sid=TextEditingController();
  final TextEditingController _name=TextEditingController();

  Future<void> _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String personName = _name.text;
    final String id=_sid.text;
    final String uemail=_emailController.text;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sign-up was successful, navigate to the login screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(), // Replace with your LoginScreen widget
        ),
      );
    } catch (e) {
      // Handle sign-up errors (e.g., email already exists, invalid password, etc.)
      print('Error during sign-up: $e');
      // You can display an error message to the user here.
    }



    FirebaseFirestore.instance.collection('Users').add({
      'PersonName': personName,
      'Student ID': id,
      'E-mail': uemail
    }).then((value) {
      // Write operation succeeded
      print('Data added successfully');
    }).catchError((error) {
      // Error occurred while sending data
      print('Error sending data to Firestore: $error');
    });

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

                const SizedBox(height: 50),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 60),
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
                          hintText: 'Email',
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
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
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
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: 'Name',
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
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Student-Id',
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
                        controller: _sid,
                        decoration: InputDecoration(
                          hintText: 'Student ID',
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
                const SizedBox(height:30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9796A1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: _passwordController,
                        onChanged: (value) {
                          // Handle password input
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: isTextFieldFocused ? const Color(0xFF9796A1) : const Color(0xFF9796A1),
                          ),
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: isTextFieldFocused ? const Color(0xFF9796A1) : const Color(0xFF9796A1),
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !isPasswordVisible,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
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
                      onPressed: _signUp,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Sign Up',
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
                SizedBox(height:40),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login Now',
                          style: TextStyle(
                            color: signUpColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Add code here to navigate to the login page
                              // For example, you can use Navigator to push the login page:
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your login page widget
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                )

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
