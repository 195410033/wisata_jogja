import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisata_jogja/models/objek_model.dart';

class DatabaseHelper {
  static Future database() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(join(databasePath, 'wisata_database.db'),
        onCreate: (database, version) {
      return database.execute(
          'CREATE TABLE wisata(id INTEGER PRIMARY KEY, nama TEXT, deskripsi TEXT, ltd TEXT, lngtd TEXT, category TEXT, createdAt DATETIME, updatedAt DATETIME)');
    }, version: 1);
  }

  static Future insert(Map<String, Object> data) async {
    final database = await DatabaseHelper.database();

    database.insert("wisata", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("berhasil ditambahkan");
  }

  static Future<List<Map<String, dynamic>>> getObjekFromDB() async {
    final database = await DatabaseHelper.database();

    return database.query("wisata", orderBy: "id DESC");
  }

  static Future delete(int id) async {
    final database = await DatabaseHelper.database();

    print('berhasil dihapus');

    return database.delete('wisata', where: 'id = ?', whereArgs: [id]);
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  static Future<List<ObjekModel>> getObjekList() async {
    var objekMapList = await getObjekFromDB(); // Get 'Map List' from database
    print('$objekMapList');
    int count = objekMapList.length;

    print('banyak data : $count');

    List<ObjekModel> objekList = [];
    // For loop to create a 'Note List' from a 'Map List'
    // objekList.add(ObjekModel.fromJson(objekMapList[0]));
    // for (int i = 0; i < count; i++) {
    //   print(objekMapList[i]);
    //   objekList.add(ObjekModel.fromJson(objekMapList[i]));
    //   print('object 2');
    // }
    objekList.add(ObjekModel.fromJson(objekMapList[0]));

    // objekList.addAll(objekMapList.map((e) => ObjekModel.fromJson(e)).toList());
    print('next');

    // print('objek list : $objekList');

    return objekList;
  }

  static Future<List<ObjekModel>> getData() async {
    final db = await DatabaseHelper.database();

    List<Map<String, dynamic>> results = await db.query('wisata');

    print('isi data : $results');

    return results.map((res) => ObjekModel.fromJson(res)).toList();
  }
}
