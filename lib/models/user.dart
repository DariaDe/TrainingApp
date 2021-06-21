import 'package:training_application/models/user_color.dart';
import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

class User {
  int id;
  String email;
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  String last_name;
  String avatar;
  UserColor userColor;

  User(
      {this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.avatar,
      this.userColor});

  @override
  String toString() {
    return 'Record{\n'
        'id: $id, \n'
        'email: $email, \n'
        'first_name: $first_name, \n'
        'last_name: $last_name, \n'
        'avatar: $avatar,}\n';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> userColorMap = userColor.toMap();
    return {
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
      'user_color_id': userColorMap['id'],
      'user_color_name': userColorMap['name'],
      'user_color_year': userColorMap['year'],
      'user_color_color': userColorMap['color']
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> colorMap = {
      'user_color_id': map['user_color_id'],
      'user_color_name': map['user_color_name'],
      'user_color_year': map['user_color_year'],
      'user_color_color': map['user_color_color'],
    };
    UserColor returnedUserColor = UserColor.fromMapUserColor(colorMap);
    return User(
        id: map['id'],
        email: map['email'],
        first_name: map['first_name'],
        last_name: map['last_name'],
        avatar: map['avatar'],
        userColor: returnedUserColor);
  }
}
