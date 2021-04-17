import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';

const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          alignment: Alignment.center,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 52.0),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsScreen()));
            },
            child: Hero(
              tag: 'profileImage',
              child: CircleAvatar(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/Cool Kids Bust.png'),
                  backgroundColor: Color(0xFFF8F2EE),
                  radius: 77.61,
                ),
                radius: 81.61,
                backgroundColor: Color(0xFF6DB9DE),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: kBottomAppBarColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            currentIndex: 1,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/Icon.svg'),
                title: Text(
                  'Users',
                  style: TextStyle(),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/Profile Icon.svg'),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('images/Frame 4.svg'),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
