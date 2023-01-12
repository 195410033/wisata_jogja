import 'package:wisata_jogja/models/image_model.dart';
import 'package:wisata_jogja/models/kategori_model.dart';

class ObjekModel {
  int? id;
  String? nama;
  String? deskripsi;
  double? ltd;
  double? lngtd;
  KategoriModel? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ImageModel>? images;

  ObjekModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.ltd,
    required this.lngtd,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  // ObjekModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   nama = json['nama'];
  //   deskripsi = json['deskripsi'];
  //   ltd = double.parse(json['ltd'].toString());
  //   lngtd = double.parse(json['lngtd'].toString());
  //   // category = KategoriModel.fromJson(json['category']);
  //   category = json['category'] != null
  //       ? KategoriModel.fromJson(json['category'])
  //       : null;
  //   // images = json['images'] != null
  //   //     ? json['images']
  //   //         .map<ImageModel>((images) => ImageModel.fromJson(images))
  //   //         .toList()
  //   //     : null;
  //   // createdAt = DateTime.parse(json['created_at']);
  //   // updatedAt = DateTime.parse(json['updated_at']);
  // }

  factory ObjekModel.fromJson(Map<String, dynamic> json) => ObjekModel(
        id: json['id'],
        nama: json['nama'],
        deskripsi: json['deskripsi'],
        ltd: double.parse(json['ltd'].toString()),
        lngtd: double.parse(json['lngtd'].toString()),
        // category = KategoriModel.fromJson(json['category']),
        category: json['category'] != null
            ? KategoriModel.fromJson(json['category'])
            : null,
        images: json['images'] != null
            ? json['images']
                .map<ImageModel>((images) => ImageModel.fromJson(images))
                .toList()
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'ltd': ltd,
      'lngtd': lngtd,
      'category': category?.toJson(),
      'images': images?.map((images) => images.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
