// import 'package:blade/controllers/offline_controller.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:blade/controllers/offline_controller.dart';
import 'package:blade/models/chapter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/theme/theme.dart';

class OfflineChapterScreen extends StatelessWidget {
  OfflineChapterScreen({required this.chapter, super.key});
  ChapterModel chapter;

  @override
  Widget build(BuildContext context) {
    OfflineController offlineController = Get.put(OfflineController());

    return Obx(
      () => Scaffold(
        appBar: offlineController.isShow.value
            ? null
            : AppBar(
                backgroundColor: AppTheme.dark.withOpacity(0.2),
                title: Text(
                  chapter.title ?? "",
                  maxLines: 1,
                ),
              ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chapter.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        Uint8List imageByte =
                            base64Decode(chapter.images![index].image!);
                        return Image.memory(
                          imageByte,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image not available');
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: offlineController.isShow.value ? 20 : 86,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    offlineController.showToggle();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.dark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(offlineController.isShow.value
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye),
                  ),
                ),
              )
            ],
          ),
        ),
        extendBody: true,
      ),
    );
  }
}
