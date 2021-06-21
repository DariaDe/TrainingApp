import 'dart:ui';

class UserColor {
  final int id;
  final String name;
  final int year;
  final Color color;

  UserColor({this.id, this.name, this.year, this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'color': color.value.toRadixString(16),
    };
  }

  static UserColor fromMapUserColor(Map<String, dynamic> map) {
    return UserColor(
        id: map['user_color_id'],
        name: map['user_color_name'],
        year: map['user_color_year'],
        color: Color(hexStringToHexInt('${map['user_color_color']}')));
  }

  static hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }
}
