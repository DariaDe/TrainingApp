import 'dart:math';
import 'package:flutter/material.dart';
import 'package:training_application/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final int userIndex;

  const UserTile({Key key, this.user, this.userIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 343.0,
          height: 194.0,
          decoration: BoxDecoration(
              color: Color(0xFFF8F2EE),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              )),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3 h 30 min ',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5BA092),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    user.first_name + ' ' + user.last_name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3C3A36),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'User Color',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3C3A36),
                    ),
                  ),
                ],
              ),
            )),
            Positioned(
              right: 29.0,
              bottom: 65.0,
              child: CircleAvatar(
                backgroundImage: AssetImage('images/profile_example.png'),
                radius: 37.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
