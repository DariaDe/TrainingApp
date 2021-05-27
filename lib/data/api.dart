import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future getUsersList(int page) async {
    final response = await http.get(
      Uri.https('reqres.in', '/api/users', {'page': '$page'}),
    );

    int statusCode = response.statusCode;
    List<dynamic> userData = [];

    if (statusCode == 200) {
      var data = response.body;

      Map<String, dynamic> map = jsonDecode(data);
      userData = map['data'];
    }
    return (userData);
  }

  Future getColorsList(int page) async {
    final response = await http.get(
      Uri.https('reqres.in', '/api/colors', {'page': '$page'}),
    );

    int statusCode = response.statusCode;
    List<dynamic> colorData = [];

    if (statusCode == 200) {
      var data = response.body;

      Map<String, dynamic> map = jsonDecode(data);
      colorData = map['data'];
    }

    return (colorData);
  }

  Future getTotalPagesCount() async {
    int page = 1;
    final response = await http.get(
      Uri.https('reqres.in', '/api/users', {'page': '$page'}),
    );

    int pagesCount = 1;

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      pagesCount = map['total_pages'];
    }

    return pagesCount;
  }
}
