import 'dart:convert';
import 'dart:typed_data';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/offline_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadChildScreen extends StatelessWidget {
  const DownloadChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OfflineController offlineController = Get.put(OfflineController());
    offlineController.fetchData();
    return Obx(
      () => offlineController.isLoading.value
          ? const Center(
              child: CupertinoActivityIndicator(
                color: AppTheme.bg,
              ),
            )
          : offlineController.data.isEmpty
              ? const Center(
                  child: Text(
                    "Татсан манга байхгүй байна.",
                  ),
                )
              : GridView.builder(
                  itemCount: offlineController.data.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    // Clean up the Base64 string
                    String cleanedBase64 =
                        offlineController.data[index]!.image!.trim();

                    // Decode the Base64 string to bytes
                    Uint8List bytes;
                    try {
                      bytes = base64Decode(cleanedBase64);
                    } catch (e) {
                      return Center(child: Text('Failed to decode image: $e'));
                    }
                    return GestureDetector(
                      onTap: () {
                        offlineController.selectedManga.value =
                            offlineController.data[index]!;
                        Get.toNamed("/offline-manga-detail",
                            arguments: [offlineController.data[index]]);
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.bg,
                              image: DecorationImage(
                                image: MemoryImage(bytes),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              offlineController.data[index]?.title ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
