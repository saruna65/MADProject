import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LostItemsList extends StatefulWidget {
  @override
  _LostItemsListState createState() => _LostItemsListState();
}

TextStyle labelStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    color: Color(0xff04724D),

    // Add other label style properties here (e.g., fontSize, fontWeight).
  ),
);


class _LostItemsListState extends State<LostItemsList> {
  late Stream<QuerySnapshot> _lostItemsStream; // Stream for lost items
  String _searchQuery = ''; // Store the user's search query

  @override
  void initState() {
    super.initState();
    // Initialize the stream for fetching lost items from Firestore
    _lostItemsStream = FirebaseFirestore.instance.collection('LostItems').orderBy('Date', descending: true) // Order by the "date" field in descending order
        .snapshots();
  }

  // Function to filter lost items based on the search query
  List<DocumentSnapshot> _filterLostItems(List<DocumentSnapshot> documents) {
    if (_searchQuery.isEmpty) {
      return documents; // If search query is empty, return all documents
    } else {
      // If search query is not empty, filter the documents
      return documents.where((document) {
        final data = document.data() as Map<String, dynamic>;
        final lostItem = data['LostItem'] ?? '';
        return lostItem.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/lostlist.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Padding(
          padding: const EdgeInsets.only(top: 100.0), // Adjust the top padding as needed
            child: StreamBuilder<QuerySnapshot>(
            stream: _lostItemsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final documents = snapshot.data!.docs;
              final filteredDocuments = _filterLostItems(documents); // Filter the documents

              return ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final document = filteredDocuments[index];

                  // Access Firestore document fields safely
                  final data = document.data() as Map<String, dynamic>?;
                  final batch = data?['Batch'] ?? '';
                  final contactNo = data?['ContactNo'] ?? '';
                  final dateTimestamp = document['Date'] as Timestamp; // Assuming 'Date' is a Timestamp field
                  final date = DateFormat('yyyy-MM-dd').format(dateTimestamp.toDate()); // Now, 'date' is a String representing the formatted date and time
                  final faculty = data?['Faculty'] ?? '';
                  final lostLocation = data?['LostLocation'] ?? '';
                  final lostItem = data?['LostItem'] ?? '';
                  final personName = data?['PersonName'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the relevant data page here
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RelevantDataPage(
                            batch: batch,
                            contactNo: contactNo,
                            date: date,
                            faculty: faculty,
                            lostLocation: lostLocation,
                            lostItem: lostItem,
                            personName: personName,
                          ),
                        ),
                      );
                    },

                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/listbtn.png'), // Replace 'assets/background_image.png' with the path to your PNG image
                          fit: BoxFit.cover,
                          // You can adjust the fit as needed
                        ),
                      ),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              '  $lostItem',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '  Lost Date: $date',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ),

          // Search input layer (on top of other content)
           Positioned(
            top: 50,
            left: 10,
            right: 10,
             child:Container(
               padding: const EdgeInsets.only(top: 8.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                 color: const Color(0xffE7E3E3), // Background color of the input box
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: TextField(
                   decoration: const InputDecoration(
                     hintText: 'Search Lost Items',
                     prefixIcon: Icon(
                       Icons.search,
                       color: Colors.black54,
                       size: 30,// icon color
                     ),
                     hintStyle: TextStyle(
                       color: Colors.black54, //hint text color
                     ),
                     border: InputBorder.none, // Remove the default border
                   ),
                   style: const TextStyle(
                     color: Colors.black54, //text color to black (or your desired color)
                   ),
                   onChanged: (value) {
                     setState(() {
                       _searchQuery = value; // Update the search query
                     });
                   },
                 ),
               ),
             ),
           ),
        ],
      ),
    );
  }
}

class RelevantDataPage extends StatelessWidget {
  final String batch;
  final String contactNo;
  final String date;
  final String faculty;
  final String lostLocation;
  final String lostItem;
  final String personName;

  RelevantDataPage({
    required this.batch,
    required this.contactNo,
    required this.date,
    required this.faculty,
    required this.lostLocation,
    required this.lostItem,
    required this.personName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 330),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.all(20),
                child: Container(
                  width: 400.0,
                  height: 530.0,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          lostItem,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          'Item Lost Person Details',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 00),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.person, size: 24), // Icon for Found Person
                            ),
                            Text(
                              personName,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.school, size: 24), // Icon for Faculty
                            ),
                            Text(
                              faculty,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.groups, size: 24), // Icon for Batch
                            ),
                            Text(
                              batch,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.phone, size: 24), // Icon for Contact No
                            ),
                            Text(
                              contactNo,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.location_on, size: 24), // Icon for Lost Location
                            ),
                            Text(
                              lostLocation,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0 , right: 36.0), // Add space in front of the icon
                              child: Icon(Icons.calendar_today, size: 24), // Icon for Date
                            ),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                onPressed: () {
                  _launchPhoneDialer(contactNo);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'CONTACT NOW',
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
    );
  }
}


void _launchPhoneDialer(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
