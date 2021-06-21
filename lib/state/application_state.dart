import 'dart:async';

import 'package:flutter/material.dart';
import 'package:training_application/data/api.dart';
import 'package:training_application/models/user.dart';
import 'package:training_application/models/user_color.dart';
import 'package:training_application/data/db.dart';
import 'package:sqflite/sqflite.dart';

class ApplicationState {
  ValueNotifier pageNotifier = ValueNotifier<int>(1);
  PageController controller = PageController(
    initialPage: 1,
  );
  int previousPageIndex;
  Api api = Api();
  DB db = DB();

  User currentUser = User();
  List<User> usersList = [];

  void goToPage(int pageIndex) {
    controller.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void goBack() {
    controller.animateToPage(previousPageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future getUsers(int page) async {
    List<dynamic> userData = await api.getUsersList(page);
    List<User> users = <User>[];

    for (Map<String, dynamic> item in userData) {
      users.add(User(
          id: item['id'],
          email: item['email'],
          first_name: item['first_name'],
          last_name: item['last_name'],
          avatar: item['avatar']));
    }

    List<dynamic> colorData = await api.getColorsList(page);
    List<UserColor> colors = <UserColor>[];

    for (Map<String, dynamic> item in colorData) {
      colors.add(UserColor(
          id: item['id'],
          name: item['name'],
          year: item['year'],
          color: Color(hexStringToHexInt(item['color']))));
    }

    for (var i = 0; i < users.length; i++) {
      for (var j = 0; j < colors.length; j++) {
        if (users[i].id == colors[j].id) {
          users[i].userColor = colors[j];
        }
      }
    }

    for (var i = 0; i < users.length; i++) {
      var database = await db.database;
      await db.insertUser(users[i]);
    }

    var existingCurrentUser = await db.getCurrentUser();
    print('Existing user ${existingCurrentUser}');
    if (existingCurrentUser != null) {
      currentUser.first_name = existingCurrentUser[0]['first_name'];
      currentUser.last_name = existingCurrentUser[0]['last_name'];
    }

    return users;
  }

  void updateCurrentUserNames(User user) async {
    currentUser = user;
    var database = await db.database;

    if (currentUser.first_name == null && currentUser.last_name == null) {
      var res = await db.insertUser(currentUser);
    } else {
      currentUser.first_name = user.first_name;
      currentUser.last_name = user.last_name;
      currentUser.id = user.id;
      currentUser.email = user.email;
      currentUser.avatar = user.avatar;
      currentUser.userColor = user.userColor;

      await db.insertUser(currentUser);
    }

    print("Current User: ${await db.getCurrentUser()}");
    print("Name ${currentUser.first_name}");
  }

  Future<List<User>> getSearchResult(String fullName) async {
    var database = await db.database;
    List<String> name = fullName.split(' ');
    var res = await db.searchFor(name[0], name[1]);
    return res;
  }

  Future getPagesCount() async {
    int pagesCount = await api.getTotalPagesCount();
    return pagesCount;
  }

  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }
}
