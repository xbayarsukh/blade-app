import 'package:blade/configs/app_database.dart';

import '../configs/globals.dart';

class ResponseModel {
  final int? status;
  final bool? success;
  final String? message;
  final dynamic data;

  ResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == 205) {
      AppDatabase().deleteData();
      tkn = "";
    }
    return ResponseModel(
      status: json["status"] ?? 301,
      success: json["success"] ?? false,
      message: json["message"] ?? '',
      data: json["data"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": data,
      };
}
