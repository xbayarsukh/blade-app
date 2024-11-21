import 'dart:async';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/ui/pages/home/child/download/download_child_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/globals.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  StreamSubscription<List<ConnectivityResult>>? subscription;
  bool connectionStatus = true;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
        connectionStatus = true;
      } else if (result.contains(ConnectivityResult.wifi)) {
        connectionStatus = true;
      } else if (result.contains(ConnectivityResult.vpn)) {
        connectionStatus = true;
      } else if (result.contains(ConnectivityResult.other)) {
        connectionStatus = false;
      } else if (result.contains(ConnectivityResult.none)) {
        connectionStatus = false;
      } else {
        connectionStatus = false;
      }

      if (connectionStatus == true) {
        Get.offAllNamed('/splash');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (usr?.dDays ?? 0) > 0
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppTheme.dark,
              title: const Text(
                "Татсан файл",
                textAlign: TextAlign.center,
              ),
            )
          : null,
      body: (usr?.dDays ?? 0) > 0
          ? const DownloadChildScreen()
          : const Center(
              child: Text("Интернет холболтоо шалгана уу."),
            ),
    );
  }
}
