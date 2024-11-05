class ChapterModel {
  int? id;
  String? title;
  String? image;
  int? mangaId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ImageModel>? images;
  bool? isDownloadLoading;

  ChapterModel({
    this.id,
    this.title,
    this.image,
    this.mangaId,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.isDownloadLoading,
  });

  ChapterModel copyWith({
    int? id,
    String? title,
    String? image,
    int? mangaId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ImageModel>? images,
    bool? isDownloadLoading,
  }) =>
      ChapterModel(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        mangaId: mangaId ?? this.mangaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        images: images ?? this.images,
        isDownloadLoading: isDownloadLoading ?? this.isDownloadLoading,
      );

  factory ChapterModel.fromJson(Map<String, dynamic> json, mangaImage) =>
      ChapterModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        image: json["image"] ?? mangaImage,
        mangaId: json["manga_id"] ?? 0,
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
        images: json["images"] == null
            ? []
            : List<ImageModel>.from(
                json["images"]!.map((x) => ImageModel.fromJson(x))),
        isDownloadLoading: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "manga_id": mangaId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "isdownloadloading": isDownloadLoading,
      };
}

class ImageModel {
  int? id;
  String? image;
  int? count;
  int? chapterId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ImageModel({
    this.id,
    this.image,
    this.count,
    this.chapterId,
    this.createdAt,
    this.updatedAt,
  });

  ImageModel copyWith({
    int? id,
    String? image,
    int? count,
    int? chapterId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ImageModel(
        id: id ?? this.id,
        image: image ?? this.image,
        count: count ?? this.count,
        chapterId: chapterId ?? this.chapterId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"] ?? 0,
        image: json["image"] ?? "",
        count: json["count"] ?? 0,
        chapterId: json["chapter_id"] ?? 0,
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "count": count,
        "chapter_id": chapterId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
