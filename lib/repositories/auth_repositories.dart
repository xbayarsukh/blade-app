import 'package:blade/models/login_response.dart';
import 'package:blade/models/response_model.dart';
import 'package:get/get.dart';
import '../configs/api_config.dart';
import '../configs/globals.dart';

class AuthRepositories {
  Future<LoginResponse> login(String email, String password) async {
    connect ??= GetConnect();
    String url = "$api/auth/login";
    final response = await connect!.post(
      url,
      {
        "email": email,
        "password": password,
        "device_id": deviceId,
      },
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
      },
    );

    return LoginResponse.fromJson(response.body ?? {});
  }

  Future<ResponseModel> getOtp(email, {isRegister = false}) async {
    connect ??= GetConnect();
    String url = "$api/auth/send-otp";
    final response = await connect!.post(
      url,
      {
        "email": email,
        "isRegister": isRegister,
      },
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
      },
    );

    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> register(email, otp, password, name) async {
    connect ??= GetConnect();
    String url = "$api/auth/register";
    final response = await connect!.post(
      url,
      {
        "name": name,
        "email": email,
        "otp_code": otp,
        "password": password,
      },
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
      },
    );

    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<ResponseModel> forgorPass(email, otp, password) async {
    connect ??= GetConnect();
    String url = "$api/auth/forgot-password";
    final response = await connect!.post(
      url,
      {
        "email": email,
        "otp_code": otp,
        "password": password,
      },
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
      },
    );

    return ResponseModel.fromJson(response.body ?? {});
  }

  Future<LoginResponse> check() async {
    connect ??= GetConnect();
    String url = "$api/auth/check";
    final response = await connect!.post(
      url,
      {
        "token": tkn ?? "",
      },
      contentType: 'application/json',
      headers: {
        "Content-Type": "application/json",
        "App-Language": "mn",
        "Accept": "application/json",
        'Authorization': 'Bearer $tkn',
      },
    );
    return LoginResponse.fromJson(response.body ?? {});
  }
}
