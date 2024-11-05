class MembershipModel {
  int? id;
  String? title;
  int? month;
  String? description;
  dynamic price;
  DateTime? createdAt;
  DateTime? updatedAt;

  MembershipModel({
    this.id,
    this.title,
    this.month,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  MembershipModel copyWith({
    int? id,
    String? title,
    int? month,
    String? description,
    dynamic price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MembershipModel(
        id: id ?? this.id,
        title: title ?? this.title,
        month: month ?? this.month,
        description: description ?? this.description,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      MembershipModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        month: json["month"] ?? 0,
        description: json["description"] ?? "",
        price: json["price"] ?? 0,
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
        "month": month,
        "description": description,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
