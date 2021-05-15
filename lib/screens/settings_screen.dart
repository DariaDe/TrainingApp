import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:training_application/widget/custom_button.dart';
import 'package:training_application/state/inherited_application_state.dart';

const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);
const kBorderFormColor = Color(0xFFBEBAB3);
const kBtnColor = Color(0xFF3789AC);
const kLogOutTextColor = Color(0xFF78746D);

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settingsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
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
            SizedBox(width: 16.0),
            CustomButton(
                icon: Icons.arrow_back_ios_rounded,
                onButtonTap: () {
                  InheritedAplicationState.of(context).goBack();
                }),
          ],
        ),
        actions: [
          Row(
            children: [
              CustomButton(
                iconSize: 20.0,
                icon: Icons.delete,
                onButtonTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
              ),
              SizedBox(width: 16.0),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 28.0,
            ),
            Center(
              child: Image.asset(
                'images/Cool Kids Bust 2.png',
              ),
            ),
            Center(
              child: Form(
                key: _settingsFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account Information',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.5,
                            color: kTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your User Name',
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: kBorderFormColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        width: double.infinity,
                        height: 56.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kBtnColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )

                              // background
                              ),
                          onPressed: () {},
                          child: Text(
                            'Edit user name',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: kLogOutTextColor,
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
