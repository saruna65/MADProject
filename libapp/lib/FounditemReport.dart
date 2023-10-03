import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';



class FoundReport extends StatefulWidget {
  const FoundReport({Key? key}) : super(key: key);

  @override
  _FoundReportState createState() => _FoundReportState();
}

TextStyle labelStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    color: Color(0xff04724D),

    // Add other label style properties here (e.g., fontSize, fontWeight).
  ),
);


class _FoundReportState extends State<FoundReport> {

  final TextEditingController personNameController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController foundItemController = TextEditingController();
  final TextEditingController foundLocationController = TextEditingController();

  void sendDataToFirebase() {
    String personName = personNameController.text;
    String faculty = facultyController.text;
    String batch = batchController.text;
    String contactNo = contactNoController.text;
    String foundItem = foundItemController.text;
    String foundLocation = foundLocationController.text;

    FirebaseFirestore.instance
        .collection('FoundItems')
        .add({

      'PersonName': personName,
      'Faculty': faculty,
      'Batch': batch,
      'ContactNo': contactNo,
      'Date': DateTime.now(),
      'Found Item': foundItem,
      'Found Location': foundLocation
    })
        .then((value) {
      // Data sent successfully
      Alert(
        context: context,

        content: const Column(
          children: [
            SizedBox(height: 25),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 16),
            Text(
              'Item Reported Successfully!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
            color: const Color(0xff04724D),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    })
        .catchError((error) {
      // Error occurred while sending data
      print('Error sending data to Firestore: $error');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF9F2), // Set the background color

      // Wrap only the Scaffold's body in a Stack widget to layer the background image
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/reportback.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              // Add your back button functionality here
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white, // Change the color to your desired color
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'REPORT FOUND ITEM',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextField(
                          controller: personNameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: facultyController,
                          decoration: InputDecoration(
                            labelText: 'Faculty',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: batchController,
                          decoration: InputDecoration(
                            labelText: 'Batch',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: contactNoController,
                          decoration: InputDecoration(
                            labelText: 'Contact No',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: foundItemController,
                          decoration: InputDecoration(
                            labelText: 'Found Item',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: foundLocationController,
                          decoration: InputDecoration(
                            labelText: 'Found Location',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff04724D)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Color(0xff0EAD77)),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelStyle: labelStyle,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          width: 200,
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
                            onPressed: sendDataToFirebase,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child:
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'REPORT NOW',
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
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

