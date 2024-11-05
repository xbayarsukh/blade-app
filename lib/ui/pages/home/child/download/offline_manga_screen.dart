import 'dart:convert';

import 'package:blade/configs/app_database.dart';
import 'package:blade/configs/globals.dart';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/offline_controller.dart';
import 'package:blade/models/chapter_model.dart';
import 'package:blade/models/manga_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class OfflineMangaScreen extends StatelessWidget {
  OfflineMangaScreen({required this.manga, super.key});
  MangaModel manga;

  @override
  Widget build(BuildContext context) {
    final OfflineController offlineController = Get.put(OfflineController());

    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: manga.title == "" || manga.title == null
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: AppTheme.bg,
                  ),
                )
              : Stack(
                  children: [
                    Image.memory(
                      base64Decode(manga.image ?? ""),
                      height: 700,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                    _buildAnimatedContainer(context, offlineController),
                  ],
                ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.dark.withOpacity(0.5),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.keyboard_arrow_left,
          color: AppTheme.bg,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(
      BuildContext context, OfflineController offlineController) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        // Added a Container to provide bounded width constraints
        width: Get.width, // Make sure the container takes the full width
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: offlineController.containerHeight.value,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.dark.withOpacity(0.1),
                AppTheme.dark.withOpacity(0.3),
                AppTheme.dark.withOpacity(0.4),
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
                AppTheme.dark,
              ],
            ),
          ),
          child: _buildScrollView(offlineController),
        ),
      ),
    );
  }

  Widget _buildScrollView(OfflineController offlineController) {
    return SingleChildScrollView(
      controller: offlineController.scrollController.value,
      child: SizedBox(
        height: Get.height - 239.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              manga.title ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 80),
            Text("Орчуулсан: ${manga.translatedBy ?? ""}").padding(vertical: 5),
            Text(
              manga.description ?? "",
              maxLines: 8,
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: AppTheme.bg,
            ),
            Expanded(
              child: manga.chapters!.isEmpty
                  ? const Center(
                      child: Text("Бүлэг нэмэгдээгүй байна"),
                    )
                  : ListView.builder(
                      itemCount: manga.chapters?.length ?? 0,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 0, bottom: 30),
                      itemBuilder: (context, index) {
                        ChapterModel? chapter = manga.chapters?[index];
                        return GestureDetector(
                          onTap: () async {
                            bool isLogin = AppDatabase().isLoggedIn();
                            if (!isLogin) {
                              Get.snackbar(
                                  "Алдаа", "Нэвтэрсэний дараа унших боломжтой");
                              Get.offAllNamed("/home", arguments: [3]);
                            } else {
                              if ((usr?.mDays ?? 0) > 0) {
                                Get.toNamed("/offline-chapter-detail",
                                    arguments: [chapter]);
                              } else {
                                Get.snackbar(
                                    "Алдаа", "Таны эрх дууссан байна.");
                              }
                            }
                          },
                          child: Container(
                            height: 100,
                            width: Get.width - 20,
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Image.memory(
                                  base64Decode(chapter?.image ?? ""),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                ).padding(right: 10),
                                SizedBox(
                                  width: Get.width - 140,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        chapter?.title ?? "",
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ).padding(horizontal: 10),
    );
  }
}
