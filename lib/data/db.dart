import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training_application/models/user.dart';
import 'dart:async';

class DB {
  static Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: userDb);
    return database;
  }

  void userDb(Database database, int version) async {
    await database.execute("CREATE TABLE User ("
        "id INTEGER PRIMARY KEY,"
        "email TEXT,"
        "first_name TEXT,"
        "last_name TEXT,"
        "avatar TEXT,"
        "user_color_id INTEGER,"
        "user_color_name TEXT,"
        "user_color_year INTEGER,"
        "user_color_color INTEGER"
        ")");
  }

  Future<bool> insertUser(User user) async {
    var existResult = await _database.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM User WHERE id = ${user.id})',
    );
    print("Exist ? ${Sqflite.firstIntValue(existResult)}");
    if (Sqflite.firstIntValue(existResult) != 0) {
      getAllUsers();
      var result = await updateCurrentUser(user);
      print("Result ${result}");
      if (result != 0)
        return true;
      else
        return false;
    } else {
      var result = await _database.insert("User", user.toMap());
      print("Result ${result}");
      if (result != null)
        return true;
      else
        return false;
    }
  }

  Future<int> updateCurrentUser(User newUserData) async {
    var result = await _database.update("User", newUserData.toMap(),
        where: "id = ?", whereArgs: [newUserData.id]);
    if (result == 1) {
      return result;
    } else
      return null;
  }

  Future<List<Map<String, dynamic>>> getCurrentUser() async {
    List<Map<String, dynamic>> currentUser = await _database.rawQuery(
      'SELECT * FROM User WHERE id = 0',
    );
    if (currentUser.isNotEmpty)
      return currentUser;
    else
      return null;
  }

  Future<List<User>> getAllUsers() async {
    print('I am in db');
    var users = await _database.rawQuery("SELECT * FROM User");

    if (users.isNotEmpty) {
      List<User> usersConverted = [];

      for (var i = 1; i < users.length; i++) {
        usersConverted.add(User.fromMap(users[i]));
      }
      return usersConverted;
    } else
      return null;
  }

  Future<List<User>> searchFor(String name, String lastName) async {
    List<Map<String, dynamic>> users = await _database.rawQuery(
      "SELECT * FROM User WHERE first_name LIKE '%${name}%' OR last_name LIKE '%${lastName}%'",
    );
    if (users.isNotEmpty) {
      List<User> usersConverted = [];

      users.forEach((element) {
        print(element);
        usersConverted.add(User.fromMap(element));
      });

      return usersConverted;
    } else
      return null;
  }
}
