// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:blade/configs/app_database.dart';
import 'package:blade/models/user_model.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  int? status;
  String? message;
  User? user;
  String? token;

  LoginResponse({
    this.success,
    this.status,
    this.message,
    this.user,
    this.token,
  });

  LoginResponse copyWith({
    bool? success,
    int? status,
    String? message,
    User? user,
    String? token,
  }) =>
      LoginResponse(
        success: success ?? this.success,
        status: status ?? this.status,
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] == 205) {
      AppDatabase().deleteData();
    }
    return LoginResponse(
      success: json["success"] ?? false,
      status: json["status"] ?? 301,
      message: json["message"] ?? "",
      user: json["data"] == null || json["data"].isEmpty
          ? null
          : User.fromJson(json["data"]["user"] ?? []),
      token: json["data"] == null || json["data"].isEmpty
          ? ""
          : json["data"]["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}
