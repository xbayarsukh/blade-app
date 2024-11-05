class CategoryModel {
  int? id;
  String? title;
  String? image;

  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel copyWith({
    int? id,
    String? title,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        image: json["image"] ?? "",
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
