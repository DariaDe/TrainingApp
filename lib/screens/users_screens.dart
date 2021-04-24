import 'dart:math';
import 'package:flutter/material.dart';
import 'package:training_application/models/user.dart';
import 'package:training_application/widget/user_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'user_info_screen.dart';

//color palette
const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

Random random = new Random();
final int randomUserCount = 1 + random.nextInt(10);

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int selectedIndex = 0;

  void _onItemtap(int index) {
    setState(() {
      this.selectedIndex = index;
      if (this.selectedIndex == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen()));
      }

      if (this.selectedIndex == 2) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SettingsScreen()));
      }
    });
  }

  static List<User> fillUsers() {
    List<User> users = [];

    for (int i = 0; i < randomUserCount; i++) {
      User newUser = User(
          id: i,
          email: "michael.lawson@reqres.in",
          first_name: "Michael",
          last_name: "Lawson",
          avatar: "https://reqres.in/img/faces/7-image.jpg");
      users.add(newUser);
    }
    return users;
  }

  final List<User> currentUsers = fillUsers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: randomUserCount,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return UserInfoScreen(cardIndex: index);
                    },
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: new SlideTransition(
                          position: new Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(0.0, 1.0),
                          ).animate(secondaryAnimation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    },
                  ));
            },
            child: Hero(
              tag: 'userCard${index}',
              child: Container(
                child: UserTile(users: currentUsers, userIndex: index),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Color(0xFFBEBAB3)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
        ),
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
            onTap: _onItemtap,
            currentIndex: this.selectedIndex,
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
