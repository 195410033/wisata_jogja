class KategoriModel {
  int? id;
  String? nama;

  KategoriModel({
    this.id,
    this.nama,
  });

  KategoriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
}
