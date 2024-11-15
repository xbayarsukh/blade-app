import 'package:blade/models/response_model.dart';
import 'package:get/get.dart';

import '../configs/api_config.dart';
import '../configs/globals.dart';

class AboutRepositories {
  Future<ResponseModel> notifications() async {
    connect ??= GetConnect();
    String url = "$api/notification-list";
    final response = await connect!.get(
      url,
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
        'Authorization': 'Bearer $tkn',
      },
    );
    Get.log(response.body.toString());
    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> about() async {
    connect ??= GetConnect();
    String url = "$api/about";
    final response = await connect!.get(
      url,
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
        'Authorization': 'Bearer $tkn',
      },
    );
    Get.log(response.body.toString());
    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> commentAdd(id, comment) async {
    connect ??= GetConnect();
    String url = "$api/comment-create/$id";
    Get.log(url);
    Get.log(tkn ?? "");
    final response = await connect!.post(
      url,
      {"comment": comment},
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
        'Authorization': 'Bearer $tkn',
      },
    );

    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> comments(id) async {
    connect ??= GetConnect();
    String url = "$api/comment-list/$id";
    Get.log(url);
    Get.log(tkn ?? "");
    final response = await connect!.get(
      url,
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
        'Authorization': 'Bearer $tkn',
      },
    );

    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> isImage() async {
    connect ??= GetConnect();
    String url = "$api/isImage";
    final response = await connect!.get(
      url,
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
      },
    );
    return ResponseModel.fromJson(response.body ?? {});
  }
}
