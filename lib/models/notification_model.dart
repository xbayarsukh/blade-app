class NotificationModel {
  int? id;
  String? title;
  String? description;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? description,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        isActive: json["is_active"] ?? 0,
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
        "description": description,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
