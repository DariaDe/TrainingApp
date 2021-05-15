import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_application/screens/profile_screen.dart';
import 'package:training_application/state/inherited_application_state.dart';
import 'landing_screen.dart';
import 'package:training_application/state/inherited_application_state.dart';

const kBorderFormColor = Color(0xFFBEBAB3);
const kTextColor = Color(0xFF3C3A36);
const kBtnColor = Color(0xFF3789AC);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool _isObscure = true;
  Color iconBtnColor = kTextColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 96.0),
            Center(
              child: Image.asset('images/Cool Kids Sitting.png'),
            ),
            Form(
              key: _loginFormKey,
              child: new Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        color: kTextColor,
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
                        hintText: 'Email',
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: kBorderFormColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не должно быть пустым!';
                        }
                        if (value.length <= 3) {
                          return 'Поле должно содержать более трех символов!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset('images/visibility 1.svg',
                              color: iconBtnColor),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                              iconBtnColor =
                                  _isObscure ? kTextColor : Colors.redAccent;
                            });
                          },
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: kBorderFormColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не должно быть пустым!';
                        }
                        if (value.length <= 3) {
                          return 'Поле должно содержать более трех символов!';
                        }
                        return null;
                      },
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
                        onPressed: () {
                          if (_loginFormKey.currentState.validate()) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return InheritedAplicationState(
                                  child: LandingScreen());
                            }));
                          }
                        },
                        child: Text(
                          'Log in',
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
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
