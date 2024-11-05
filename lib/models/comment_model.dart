class CommentModel {
  int? id;
  int? userId;
  String? comment;
  int? mangaId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  CommentModel({
    this.id,
    this.userId,
    this.comment,
    this.mangaId,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  CommentModel copyWith({
    int? id,
    int? userId,
    String? comment,
    int? mangaId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
  }) =>
      CommentModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        comment: comment ?? this.comment,
        mangaId: mangaId ?? this.mangaId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        comment: json["comment"] ?? "",
        mangaId: json["manga_id"] ?? 0,
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "comment": comment,
        "manga_id": mangaId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}
