class User {
  int? id;
  String? name;
  dynamic avatar;
  String? email;
  dynamic emailVerifiedAt;
  int? role;
  dynamic premium;
  dynamic membership;
  String? otpCode;
  dynamic expireDate;
  dynamic download;
  String? deviceId;
  int? isActive;
  int? dDays;
  int? mDays;
  int? pDays;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.premium,
    this.membership,
    this.otpCode,
    this.expireDate,
    this.download,
    this.deviceId,
    this.isActive,
    this.dDays,
    this.mDays,
    this.pDays,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    dynamic avatar,
    String? email,
    dynamic emailVerifiedAt,
    int? role,
    dynamic premium,
    dynamic membership,
    String? otpCode,
    dynamic expireDate,
    dynamic download,
    String? deviceId,
    int? isActive,
    int? dDays,
    int? mDays,
    int? pDays,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        role: role ?? this.role,
        premium: premium ?? this.premium,
        membership: membership ?? this.membership,
        otpCode: otpCode ?? this.otpCode,
        expireDate: expireDate ?? this.expireDate,
        download: download ?? this.download,
        deviceId: deviceId ?? this.deviceId,
        isActive: isActive ?? this.isActive,
        dDays: dDays ?? this.dDays,
        mDays: mDays ?? this.mDays,
        pDays: pDays ?? this.pDays,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) {
    DateTime now = DateTime.now();
    DateTime pDate = DateTime.parse(json["premium"] ??
        DateTime.now().subtract(const Duration(days: 1)).toString());
    Duration differenceP = pDate.difference(now);
    int secondsDifferenceP = differenceP.inDays;
    DateTime mDate = DateTime.parse(json["membership"] ??
        DateTime.now().subtract(const Duration(days: 1)).toString());
    Duration differenceM = mDate.difference(now);
    int secondsDifferenceM = differenceM.inDays;
    DateTime dDate = DateTime.parse(json["download"] ??
        DateTime.now().subtract(const Duration(days: 1)).toString());
    Duration differenceD = dDate.difference(now);
    int secondsDifferenceD = differenceD.inDays;

    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      avatar: json["avatar"] ?? "",
      email: json["email"] ?? "",
      emailVerifiedAt: json["email_verified_at"] ?? "",
      role: json["role"] ?? 0,
      premium: DateTime.parse(json["premium"] ??
          DateTime.now().subtract(const Duration(days: 1)).toString()),
      membership: DateTime.parse(json["membership"] ??
          DateTime.now().subtract(const Duration(days: 1)).toString()),
      otpCode: json["otp_code"] ?? "",
      expireDate: DateTime.parse(json["expire_date"] ??
          DateTime.now().subtract(const Duration(days: 1)).toString()),
      download: DateTime.parse(json["download"] ??
          DateTime.now().subtract(const Duration(days: 1)).toString()),
      deviceId: json["device_id"] ?? "",
      isActive: json["is_active"] ?? 0,
      dDays: secondsDifferenceD,
      mDays: secondsDifferenceM,
      pDays: secondsDifferenceP,
      createdAt: json["created_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "premium": premium.toString(),
        "membership": membership.toString(),
        "otp_code": otpCode,
        "expire_date": expireDate.toString(),
        "download": download.toString(),
        "device_id": deviceId,
        "is_active": isActive,
        "dDays": dDays,
        "mDays": mDays,
        "pDays": pDays,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}
