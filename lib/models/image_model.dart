class ImageModel {
  int? id;
  String? images;

  ImageModel({
    this.id,
    this.images,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'images': images,
    };
  }
}
