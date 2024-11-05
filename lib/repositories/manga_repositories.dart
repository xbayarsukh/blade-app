import 'package:blade/configs/api_config.dart';
import 'package:blade/models/response_model.dart';
import 'package:get/get.dart';

import '../configs/globals.dart';

class MangaRepositories {
  Future<ResponseModel> slideManga() async {
    connect ??= GetConnect();
    String url = "$api/slide-manga-list";
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

  Future<ResponseModel> newManga() async {
    connect ??= GetConnect();
    String url = "$api/new-manga-list";
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

  Future<ResponseModel> ongoingManga() async {
    connect ??= GetConnect();
    String url = "$api/ongoing-manga-list";
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

  Future<ResponseModel> finishManga() async {
    connect ??= GetConnect();
    String url = "$api/finish-manga-list";
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

  Future<ResponseModel> premiumManga() async {
    connect ??= GetConnect();
    String url = "$api/premium-manga-list";
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

  Future<ResponseModel> detailManga(id) async {
    connect ??= GetConnect();
    String url = "$api/manga/$id";
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

  Future<ResponseModel> chapterDetail(id, mangaId) async {
    connect ??= GetConnect();
    String url = "$api/chapter/$id?manga_id=$mangaId";
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

  Future<ResponseModel> getCategories() async {
    connect ??= GetConnect();
    String url = "$api/categories-list";
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

  Future<ResponseModel> getCategoryManga(id) async {
    connect ??= GetConnect();
    String url = "$api/category-manga-list/$id";
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

  Future<ResponseModel> updateFavourite(id, status) async {
    connect ??= GetConnect();
    String url = "$api/favourite-update/$id";
    final response = await connect!.post(
      url,
      {"status": status},
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

  Future<ResponseModel> favMangas() async {
    connect ??= GetConnect();
    String url = "$api/favourite-list";
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

  Future<ResponseModel> memberships() async {
    connect ??= GetConnect();
    String url = "$api/membership-list";
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
}
