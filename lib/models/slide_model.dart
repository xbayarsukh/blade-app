class SlideModel {
  int? id;
  String? image;
  int? mangaId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SlideModel({
    this.id,
    this.image,
    this.mangaId,
    this.createdAt,
    this.updatedAt,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) => SlideModel(
        id: json["id"] ?? 0,
        image: json["image"] ?? "",
        mangaId: json["manga_id"] ?? 0,
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "manga_id": mangaId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
