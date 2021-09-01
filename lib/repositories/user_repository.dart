import 'dart:async';
import 'dart:io';

import 'package:crud/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "user.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE User(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          lastName TEXT)""");
    });
  }

  Future<List<UserModel>> getUsers() async {
    final db = await init();
    final maps = await db.query("User");

    return List.generate(maps.length, (i) {
      return UserModel(
        maps[i]['name'] as String,
        maps[i]['lastName'] as String,
        id: maps[i]['id'].toString() ,
      );
    });
  }

  Future<int> addUser(UserModel user) async {
    final db = await init();

    return db.insert(
      "User",
      user.toMapInsert(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await init();

    int result = await db.delete("User", where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await init();

    int result = await db
        .update("User", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    return result;
  }
}
