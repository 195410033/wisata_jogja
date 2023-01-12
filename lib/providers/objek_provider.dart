import 'package:flutter/material.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/services/objek_service.dart';

class ObjekProvider with ChangeNotifier {
  List<ObjekModel> _objek = [];

  List<ObjekModel> get objek => _objek;

  set objek(List<ObjekModel> objek) {
    _objek = objek;
    notifyListeners();
  }

  Future<void> getObjek() async {
    try {
      List<ObjekModel> objek = await ObjekService().getObjek();
      _objek = objek;
    } catch (e) {
      print(e);
    }
  }
}
