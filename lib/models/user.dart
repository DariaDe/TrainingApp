import 'package:training_application/models/user_color.dart';

class User {
  final int id;
  final String email;
  // ignore: non_constant_identifier_names
  final String first_name;
  // ignore: non_constant_identifier_names
  final String last_name;
  final String avatar;
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
}
