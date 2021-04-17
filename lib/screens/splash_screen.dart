import 'dart:async';

import 'package:flutter/material.dart';

import 'login_screen.dart';

const kTextColor = Color(0xFF3C3A36);

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('Im on Splash');
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('images/Cool Kids On Wheels.png')),
          SizedBox(
            height: 16.0,
          ),
          Column(children: [
            Text(
              'SköL@',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Rubik',
                color: kTextColor,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.0,
              ),
            ),
            Text(
              'Flutter Dev',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Rubik',
                color: kTextColor,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.0,
              ),
            ),
          ]),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
