import 'package:blade/models/chapter_model.dart';

class MangaModel {
  int? id;
  String? title;
  String? description;
  String? translatedBy;
  String? image;
  int? categoryId;
  String? type;
  String? lastEpisode;
  List<ChapterModel>? chapters;
  int? isfavourite;
  int? lastChapterId;
  DateTime? createdAt;
  DateTime? updatedAt;

  MangaModel({
    this.id,
    this.title,
    this.description,
    this.translatedBy,
    this.image,
    this.categoryId,
    this.type,
    this.lastEpisode,
    this.chapters,
    this.isfavourite,
    this.lastChapterId,
    this.createdAt,
    this.updatedAt,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        translatedBy: json["translated_by"] ?? "",
        image: json["image"] ?? "",
        categoryId: json["category_id"] ?? 0,
        type: json["type"] ?? "finished",
        lastEpisode: json["latest_chapter_count"] == null
            ? ""
            : "${json["latest_chapter_count"]}-р бүлэг",
        chapters: json["chapters"] == null
            ? []
            : List<ChapterModel>.from(json["chapters"]
                .map((x) => ChapterModel.fromJson(x, json["image"]))),
        isfavourite: json["is_favourite"] ?? 0,
        lastChapterId: json["last_chapter_id"] ?? 0,
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "translated_by": translatedBy,
        "image": image,
        "category_id": categoryId,
        "type": type,
        "latest_chapter_count": lastEpisode,
        "chapters": chapters == null
            ? []
            : List<dynamic>.from(chapters!.map((x) => x.toJson())),
        "is_favourite": isfavourite,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
