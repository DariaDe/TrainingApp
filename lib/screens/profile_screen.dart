import 'package:flutter/material.dart';

import 'settings_screen.dart';

import 'login_screen.dart';
import 'package:training_application/widget/custom_button.dart';

const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: Row(
            children: [
              SizedBox(
                width: 16.0,
              ),
              CustomButton(
                icon: Icons.arrow_back_ios_rounded,
                onButtonTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
              )
            ],
          )),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 52.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsScreen()));
            },
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
        ],
      ),
    );
  }
}
