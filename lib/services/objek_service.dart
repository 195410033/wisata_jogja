import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wisata_jogja/models/objek_model.dart';

class ObjekService {
  String baseUrl = 'https://aviothic.id/api';

  Future<List<ObjekModel>> getObjek() async {
    var url = Uri.parse('$baseUrl/objek');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ObjekModel> objek = [];

      for (var item in data) {
        objek.add(ObjekModel.fromJson(item));
      }

      return objek;
    } else {
      throw Exception('Gagal get objek');
    }
  }
}
