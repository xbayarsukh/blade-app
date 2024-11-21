import 'dart:convert';
import 'package:blade/configs/globals.dart';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/manga_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:styled_widget/styled_widget.dart';

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen({required this.id, super.key});
  final int id;

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final _noScreenshot = NoScreenshot.instance;
  void disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  void enableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Enable Screenshot: $result');
  }

  @override
  void initState() {
    super.initState();
    disableScreenshot();
  }

  @override
  void dispose() {
    super.dispose();
    enableScreenshot();
  }

  @override
  Widget build(BuildContext context) {
    MangaController mangaController = Get.put(MangaController());

    mangaController.fetchChapter(widget.id);

    return Obx(
      () => Scaffold(
        appBar: mangaController.isShow.value
            ? null
            : AppBar(
                backgroundColor: AppTheme.dark.withOpacity(0.2),
                title: Text(
                  mangaController.selectedChapter.value.title ?? "",
                  maxLines: 1,
                ),
              ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: mangaController.isLoadingChapter.value == true
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: AppTheme.bg,
                  ),
                )
              : usr!.email == "test1@gmail.com"
                  ? HtmlWidget(
                          mangaController.selectedChapter.value.description ??
                              "")
                      .padding(
                      horizontal: 20,
                      top: MediaQuery.of(context).padding.top + 50,
                    )
                  : Stack(
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
                                itemCount: mangaController
                                        .selectedChapter.value.images?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  Uint8List imageByte = base64Decode(
                                      mangaController.selectedChapter.value
                                          .images![index].image!);
                                  return Image.memory(
                                    imageByte,
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
                          bottom: mangaController.isShow.value ? 20 : 86,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              mangaController.showToggle();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.dark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(mangaController.isShow.value
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye),
                            ),
                          ),
                        )
                      ],
                    ),
        ),
        extendBody: true,
        bottomNavigationBar: mangaController.isShow.value
            ? const SizedBox(
                height: 0,
              )
            : Container(
                width: Get.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppTheme.dark,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    mangaController.selectedChapterIndex.value == 0
                        ? SizedBox(
                            width: (Get.width - 2) / 2,
                          )
                        : GestureDetector(
                            onTap: () {
                              mangaController.fetchChapter(mangaController
                                  .selectedManga
                                  .value
                                  .chapters![mangaController
                                          .selectedChapterIndex.value -
                                      1]
                                  .id);
                              mangaController.lastChapterId.value =
                                  mangaController
                                          .selectedManga
                                          .value
                                          .chapters![mangaController
                                                  .selectedChapterIndex.value -
                                              1]
                                          .id ??
                                      0;
                              mangaController.lastChapterIndex.value =
                                  mangaController.selectedChapterIndex.value -
                                      1;
                              mangaController.setChapterIndex(
                                  mangaController.selectedChapterIndex.value -
                                      1);
                            },
                            child: SizedBox(
                              width: (Get.width - 2) / 2,
                              child: const Center(
                                child: Text("Өмнөх"),
                              ),
                            ),
                          ),
                    Container(
                      width: 2,
                      height: 80,
                      color: AppTheme.bg,
                    ),
                    mangaController.selectedChapterIndex.value ==
                            (mangaController
                                    .selectedManga.value.chapters!.length -
                                1)
                        ? SizedBox(
                            width: (Get.width - 2) / 2,
                          )
                        : GestureDetector(
                            onTap: () {
                              mangaController.fetchChapter(mangaController
                                  .selectedManga
                                  .value
                                  .chapters![mangaController
                                          .selectedChapterIndex.value +
                                      1]
                                  .id);
                              mangaController.lastChapterId.value =
                                  mangaController
                                          .selectedManga
                                          .value
                                          .chapters![mangaController
                                                  .selectedChapterIndex.value +
                                              1]
                                          .id ??
                                      0;
                              mangaController.lastChapterIndex.value =
                                  mangaController.selectedChapterIndex.value +
                                      1;
                              mangaController.setChapterIndex(
                                  mangaController.selectedChapterIndex.value +
                                      1);
                            },
                            child: SizedBox(
                              width: (Get.width - 2) / 2,
                              child: const Center(
                                child: Text("Дараах"),
                              ),
                            ),
                          )
                  ],
                ),
              ),
      ),
    );
  }
}
