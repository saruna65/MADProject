import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libapp/loginscreen.dart';

import 'forgetpassword.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot>? userDocuments; // Use a list to store multiple documents
  String? error; // Add error variable to store error messages

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore using the user's email
    FirebaseFirestore.instance
        .collection('Users')
        .where('E-mail', isEqualTo: user?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userDocuments = querySnapshot.docs; // Store the matching documents in the list
          error = null; // Clear any previous errors
        });
      } else {
        setState(() {
          error = 'No data available'; // Set an error message if no data is found
        });
      }
    }).catchError((error) {
      setState(() {
        this.error = 'Error fetching user data: $error'; // Set an error message for a database error
      });
    });
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // After signing out, navigate to the login screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40.0),
              const SizedBox(height: 20.0),
              const CircleAvatar(
                radius: 60.0,
                backgroundColor: Color(0xff0EAD77),
                child: Icon(
                  Icons.person,
                  size: 80.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 60.0),
              ListTile(
                leading: const Icon(Icons.email),
                title: Row(
                  children: [
                    const Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        user?.email ?? 'No email available',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              if (error != null)
                Text(
                  'Error: $error',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                )
              else if (userDocuments != null)
                Column(
                  children: userDocuments!.map((doc) {
                    final userData = doc.data() as Map<String, dynamic>;

                    final personName = userData['PersonName'] ?? 'No name available';
                    final studentId = userData['Student ID'] ?? 'No Student ID available';

                    return Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Row(
                            children: [
                              const Text(
                                'Name:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  personName,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.confirmation_number),
                          title: Row(
                            children: [
                              const Text(
                                'Student ID:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  studentId,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 70.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF55B799), Color(0xFF5DDFBC)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PasswordResetScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Reset Password',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Sign out the user
                      _signOut(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Container(
                      width: 150,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Out',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
