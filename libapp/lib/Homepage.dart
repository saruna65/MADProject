import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:libapp/FounditemReport.dart';
import 'package:libapp/Itemlist.dart';
import 'package:libapp/LostReport.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF9F2), // Set the background to transparent

      // Wrap only the Scaffold's body in a Stack widget to layer the background image
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/homeback.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    width: 320,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/btndesign.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LostReport()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'REPORT LOST ITEM',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black45,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    width: 320,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/btndesign.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const FoundReport()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'REPORT FOUND ITEM',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black45,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
