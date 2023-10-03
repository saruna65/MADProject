import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:libapp/Homepage.dart';
import 'package:libapp/Itemlist.dart';
import 'package:libapp/userprofile.dart';
import 'founditemlist.dart';
import 'loginscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;


  int myIndex = 0;
  List<Widget> widgetList = [
    const HomeScreen(),
    FoundItemList(),
    LostItemsList(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF9F2),
      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: GNav(
          backgroundColor: Colors.white,
          activeColor: const Color(0xff04724D),
          gap: 8,
          selectedIndex: myIndex,
          onTabChange: (index) {
            setState(() {
              myIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Ionicons.home,
              iconColor: Colors.grey,
              iconActiveColor: Color(0xff04724D),
              iconSize: 30,
              text: 'Home',
            ),
            GButton(
              icon: Ionicons.archive,
              iconColor: Colors.grey,
              iconActiveColor: Color(0xff04724D),
              iconSize: 30,
              text: 'Found',
            ),
            GButton(
              icon: Ionicons.warning,
              iconColor: Colors.grey,
              iconActiveColor: Colors.red,
              textColor: Colors.redAccent,
              iconSize: 30,
              text: 'Lost',
            ),
            GButton(
              icon: Ionicons.person,
              iconColor: Colors.grey,
              iconActiveColor: Color(0xff04724D),
              iconSize: 30,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
