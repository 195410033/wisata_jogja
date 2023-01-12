import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisata_jogja/helper/database_helper.dart';
import 'package:wisata_jogja/helper/database_manager.dart';
import 'package:wisata_jogja/models/objek_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<ObjekModel> _favorite = [];

  List<ObjekModel> get favorite => _favorite;

  set favorite(List<ObjekModel> favorite) {
    _favorite = favorite;
    notifyListeners();
  }

  DatabaseManager database = DatabaseManager.instance;

  setObjek(ObjekModel objek) async {
    // Database db = await database.db;
    if (!isFavorite(objek)) {
      _favorite.add(objek);

      // db.insert('todos', {
      //   'id': objek.id!,
      //   'nama': objek.nama!,
      //   'deskripsi': objek.deskripsi!,
      //   'ltd': objek.ltd!,
      //   'lngtd': objek.lngtd!,
      //   'category': objek.category!.nama!,
      //   // 'createdAt': objek.createdAt!,
      //   // 'updatedAt': objek.updatedAt!,
      //   // 'images': objek.images!,
      // });
      // List<Map<String, dynamic>> data = await db.query('todos');
      // print(data);
    } else {
      _favorite.removeWhere((element) => element.id == objek.id);
      // DatabaseHelper.delete(objek.id!);
      // db.delete('todos');
    }
    notifyListeners();
  }

  // Future<void> getObjek() async {
  //   await Future.delayed(const Duration(milliseconds: 2000), () {});
  //   notifyListeners();
  //   Database db = await database.db;
  //   List<Map<String, dynamic>> favorite = await db.query('todos');

  //   // List<ObjekModel> favorite = await DatabaseHelper.getObjekList();
  //   print(favorite);

  //   // print('$favorite');
  //   // _favorite.clear();
  //   // print('bersih');
  //   // _favorite.addAll(favorite);
  //   print('bersih');
  //   notifyListeners();
  // }

  isFavorite(ObjekModel objek) {
    if (_favorite.indexWhere((element) => element.id == objek.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
