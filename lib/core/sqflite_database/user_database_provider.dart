import 'dart:async';

import 'package:path/path.dart';
import 'package:seyyah/core/sqflite_database/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseProvider {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await openDb();
    }
    return _db;
  }

  Future<Database> openDb() async {
    String dbPath = join(await getDatabasesPath(), "user.db");
    var userDb =
        await openDatabase(dbPath, version: 1, onCreate: createDatabase);
    return userDb;
  }

  void createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE userTable
        (id INTEGER PRIMARY KEY,
        username VARCHAR(40),
        password VARCHAR(20),
        mail VARCHAR(20))''');
  }

  Future<List<UserModel>> getUserData() async {
    Database db = await this.db;
    var result = await db.query("userTable");
    return List.generate(result.length, (i) {
      return UserModel.fromJson(result[i]);
    });
  }

  Future<int> insert(UserModel userModel) async {
    Database db = await this.db;
    var result = await db.insert("userTable", userModel.toJson());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.delete(
      "userTable",
      where: "id=?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> update(int id, UserModel userModel) async {
    Database db = await this.db;
    var result = await db.update(
      "userTable",
      userModel.toJson(),
      where: "id=?",
      whereArgs: [id],
    );
    return result;
  }
}
