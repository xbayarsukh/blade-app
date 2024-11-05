import 'dart:async';

import 'package:blade/configs/app_database.dart';
import 'package:blade/configs/config_notification.dart';
import 'package:blade/configs/globals.dart';
import 'package:blade/models/login_response.dart';
import 'package:blade/repositories/auth_repositories.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import '../configs/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String version = "1.0.0";
  StreamSubscription<List<ConnectivityResult>>? subscription;
  bool connectionStatus = true;

  @override
  void initState() {
    super.initState();

    initial();
  }

  initial() async {
    usr = AppDatabase().getUser();
    tkn = AppDatabase().getAccessToken();
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      connectionStatus = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      connectionStatus = true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      connectionStatus = true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      connectionStatus = false;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      connectionStatus = false;
    } else {
      connectionStatus = false;
    }

    if (mounted) {
      setState(() {});
    }

    if (connectionStatus) {
      if (tkn == "" || tkn == null) {
      } else {
        LoginResponse response = await AuthRepositories().check();
        if (response.status == 200 && response.success == true) {
          usr = response.user;
          tkn = response.token;
          await AppDatabase().saveToken(response.token ?? "");
          await AppDatabase().saveUser(response.user!);
        }
      }
      await ConfigNotification().initialize();
      await Future.delayed(const Duration(seconds: 1)).then((onValue) {
        Get.offAllNamed("/home");
      });
    } else {
      Get.offAllNamed('/offline-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/text_logo.png",
                height: 160,
              ),
              Column(
                children: [
                  Text(
                    version,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Developed by MangaGate",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ).padding(bottom: 10),
            ],
          ),
        ),
      ),
    );
  }
}
