import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  //privateconst
  DatabaseManager._privateConst();
  static DatabaseManager instance = DatabaseManager._privateConst();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future _initDB() async {
    //membuat database
    Directory docDirectory = await getApplicationDocumentsDirectory();

    String path = join(docDirectory.path, 'todo.db');

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      return await database.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY, nama TEXT, deskripsi TEXT, ltd TEXT, lngtd TEXT, category TEXT, 
          )
        ''');
    });
  }
}
