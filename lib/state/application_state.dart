import 'dart:async';

import 'package:flutter/material.dart';
import 'package:training_application/data/api.dart';
import 'package:training_application/models/user.dart';
import 'package:training_application/models/user_color.dart';
import 'package:string_to_hex/string_to_hex.dart';

class ApplicationState {
  ValueNotifier pageNotifier = ValueNotifier<int>(1);
  PageController controller = PageController(
    initialPage: 1,
  );
  int previousPageIndex;
  Api api = Api();

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

    print(users);

    return users;
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
