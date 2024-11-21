// ignore_for_file: dead_code

import 'dart:convert';
import 'package:blade/configs/app_database.dart';
import 'package:blade/configs/globals.dart';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/manga_controller.dart';
import 'package:blade/models/comment_model.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/about_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class MangaDetailScreen extends StatefulWidget {
  MangaDetailScreen({required this.id, super.key});
  int id;
  @override
  State<MangaDetailScreen> createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  fetch() async {
    isLoading = true;
    ResponseModel response = await AboutRepositories().comments(widget.id);
    if (response.status == 200 && response.success == true) {
      comments.clear();
      comments.addAll(List<CommentModel>.from(
          response.data.map((x) => CommentModel.fromJson(x))));
      Get.log("load");
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    final MangaController mangaController = Get.put(MangaController());
    mangaController.fetchDetail(widget.id);

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.dark.withOpacity(0.5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: AppTheme.bg,
                  size: 30,
                ),
              ),
              mangaController.selectedManga.value.title == null ||
                      !AppDatabase().isLoggedIn()
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        if (mangaController.isLoadingFav.value == true) {
                          Get.snackbar("Алдаа", "Уншиж байна түр хүлээнэ үү.");
                        } else {
                          mangaController.updateFav(
                              mangaController.selectedManga.value.id,
                              mangaController.isFav.value == 1 ? 0 : 1);
                        }
                      },
                      icon: Icon(
                        mangaController.isFav.value == 0
                            ? CupertinoIcons.heart
                            : CupertinoIcons.heart_slash,
                        color: AppTheme.bg,
                        size: 30,
                      ),
                    ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: mangaController.isLoadingDetail.value
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: AppTheme.bg,
                  ),
                )
              : Stack(
                  children: [
                    if (isImage == 1)
                      Image.memory(
                        base64Decode(
                            mangaController.selectedManga.value.image ?? ""),
                        height: 700,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        // Added a Container to provide bounded width constraints
                        width: Get
                            .width, // Make sure the container takes the full width
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: mangaController.containerHeight.value,
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
                          child: SingleChildScrollView(
                            controller: mangaController.scrollController.value,
                            child: SizedBox(
                              height: Get.height - 239.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mangaController.selectedManga.value.title ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).padding(top: 80),
                                  Text("Орчуулсан: ${mangaController.selectedManga.value.translatedBy ?? ""}")
                                      .padding(vertical: 5),
                                  Text(
                                    mangaController
                                            .selectedManga.value.description ??
                                        "",
                                    maxLines: 8,
                                  ),
                                  const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: AppTheme.bg,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.dialog(
                                        StatefulBuilder(
                                            builder: (context, setState5) {
                                          return Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: Container(
                                              width: Get.width - 20,
                                              height: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 74, 74),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Text(
                                                        "Сэтгэгдэл",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ).padding(
                                                          horizontal: 20,
                                                          vertical: 14),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              comments.length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                                  index2) =>
                                                              Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    left: 20,
                                                                    right: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(comments[index2].name ??
                                                                            "")
                                                                      ],
                                                                    ),
                                                                    Text(comments[index2]
                                                                            .comment ??
                                                                        ""),
                                                                  ],
                                                                ).padding(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                const Positioned(
                                                                  right: 10,
                                                                  bottom: 0,
                                                                  child: Text(
                                                                      "data"),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: TextField(
                                                              controller:
                                                                  commentController,
                                                              onChanged:
                                                                  (value) {
                                                                commentController
                                                                        .text =
                                                                    value;
                                                                setState5(
                                                                    () {});
                                                              },
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    "Чат бичих...",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Color(
                                                                      0xffD0D0D0),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: AppTheme
                                                                        .primary,
                                                                    width: 1.5,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8.0)),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xffF1F1F1),
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8.0)),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            16.0,
                                                                        vertical:
                                                                            12.0),
                                                              ),
                                                            ).padding(
                                                                left: 5,
                                                                bottom: 5),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              isLoading = true;
                                                              setState5(() {});
                                                              if (commentController
                                                                      .text ==
                                                                  "") {
                                                                Get.snackbar(
                                                                    "Алдаа",
                                                                    "Сэтгэгдэл хоосон байна.");
                                                                isLoading =
                                                                    false;
                                                                setState5(
                                                                    () {});
                                                              } else {
                                                                comments
                                                                    .clear();
                                                                ResponseModel
                                                                    responseSend =
                                                                    await AboutRepositories().commentAdd(
                                                                        widget
                                                                            .id,
                                                                        commentController
                                                                            .text);
                                                                if (responseSend
                                                                            .status ==
                                                                        200 &&
                                                                    responseSend
                                                                            .success ==
                                                                        true) {
                                                                  Get.snackbar(
                                                                      "Амжилттай",
                                                                      responseSend
                                                                              .message ??
                                                                          "");
                                                                  ResponseModel
                                                                      response =
                                                                      await AboutRepositories()
                                                                          .comments(
                                                                              widget.id);

                                                                  if (response.status ==
                                                                          200 &&
                                                                      response.success ==
                                                                          true) {
                                                                    comments.addAll(List<
                                                                            CommentModel>.from(
                                                                        response
                                                                            .data
                                                                            .map((x) =>
                                                                                CommentModel.fromJson(x))));
                                                                    Get.log(
                                                                        "load");
                                                                    isLoading =
                                                                        false;
                                                                  }
                                                                  isLoading =
                                                                      false;
                                                                  setState5(
                                                                      () {});
                                                                } else {
                                                                  Get.snackbar(
                                                                      "Алдаа",
                                                                      responseSend
                                                                              .message ??
                                                                          "");
                                                                  isLoading =
                                                                      false;
                                                                }
                                                                Get.log(isLoading
                                                                    .toString());
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 44,
                                                              height: 44,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom: 5,
                                                                      left: 5,
                                                                      right: 5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              child: Center(
                                                                child: isLoading
                                                                    ? const CupertinoActivityIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_up,
                                                                      ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                        child: const Icon(
                                                            CupertinoIcons
                                                                .xmark),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Сэтгэгдэл"),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 20,
                                    thickness: 1,
                                    color: AppTheme.bg,
                                  ),
                                  Expanded(
                                    child: mangaController.selectedManga.value
                                            .chapters!.isEmpty
                                        ? const Center(
                                            child:
                                                Text("Бүлэг нэмэгдээгүй байна"),
                                          )
                                        : ListView.builder(
                                            itemCount: mangaController
                                                    .selectedManga
                                                    .value
                                                    .chapters
                                                    ?.length ??
                                                0,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 60),
                                            itemBuilder: (context, index) {
                                              mangaController.isDownloadLoading
                                                  .add(false);

                                              return GestureDetector(
                                                onTap: () {
                                                  if (!AppDatabase()
                                                      .isLoggedIn()) {
                                                    Get.snackbar("Алдаа",
                                                        "Нэвтэрсэний дараа унших боломжтой");
                                                    Get.offAllNamed("/home",
                                                        arguments: [
                                                          (usr?.dDays ?? 0) > 0
                                                              ? 3
                                                              : 2
                                                        ]);
                                                  } else {
                                                    if (mangaController
                                                            .selectedManga
                                                            .value
                                                            .type ==
                                                        "premium") {
                                                      if ((usr?.mDays ?? 0) >
                                                              0 &&
                                                          (usr?.pDays ?? 0) >
                                                              0) {
                                                        Get.toNamed(
                                                            "/chapter-detail",
                                                            arguments: [
                                                              mangaController
                                                                      .selectedManga
                                                                      .value
                                                                      .chapters?[
                                                                          index]
                                                                      .id ??
                                                                  0
                                                            ]);
                                                        mangaController
                                                            .setChapterIndex(
                                                                index);
                                                        mangaController
                                                                .lastChapterId
                                                                .value =
                                                            mangaController
                                                                    .selectedManga
                                                                    .value
                                                                    .chapters?[
                                                                        index]
                                                                    .id ??
                                                                0;
                                                        mangaController
                                                            .lastChapterIndex
                                                            .value = index;
                                                      } else {
                                                        Get.snackbar("Алдаа",
                                                            "Premium эрхээ сунгаж байж унших боломжтой");
                                                        Get.offAllNamed("/home",
                                                            arguments: [
                                                              (usr?.dDays ??
                                                                          0) >
                                                                      0
                                                                  ? 3
                                                                  : 2
                                                            ]);
                                                      }
                                                    } else {
                                                      if ((usr?.mDays ?? 0) >
                                                          0) {
                                                        Get.toNamed(
                                                            "/chapter-detail",
                                                            arguments: [
                                                              mangaController
                                                                      .selectedManga
                                                                      .value
                                                                      .chapters?[
                                                                          index]
                                                                      .id ??
                                                                  0
                                                            ]);
                                                        mangaController
                                                                .lastChapterId
                                                                .value =
                                                            mangaController
                                                                    .selectedManga
                                                                    .value
                                                                    .chapters?[
                                                                        index]
                                                                    .id ??
                                                                0;
                                                        mangaController
                                                            .lastChapterIndex
                                                            .value = index;
                                                        mangaController
                                                            .setChapterIndex(
                                                                index);
                                                      } else {
                                                        Get.snackbar("Алдаа",
                                                            "Эрхээ сунгаж байж унших боломжтой");
                                                        Get.offAllNamed("/home",
                                                            arguments: [
                                                              (usr?.dDays ??
                                                                          0) >
                                                                      0
                                                                  ? 3
                                                                  : 2
                                                            ]);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: Get.width - 20,
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: Row(
                                                    children: [
                                                      if (isImage == 1)
                                                        Image.memory(
                                                          base64Decode(
                                                              mangaController
                                                                      .selectedManga
                                                                      .value
                                                                      .chapters?[
                                                                          index]
                                                                      .image ??
                                                                  ""),
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                          gaplessPlayback: true,
                                                        ).padding(right: 10),
                                                      SizedBox(
                                                        width: Get.width - 140,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              mangaController
                                                                      .selectedManga
                                                                      .value
                                                                      .chapters?[
                                                                          index]
                                                                      .title ??
                                                                  "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            if ((mangaController.downloadStatusList[
                                                                            index] ==
                                                                        false &&
                                                                    AppDatabase()
                                                                        .isLoggedIn() &&
                                                                    (usr?.dDays ??
                                                                            0) >
                                                                        0) &&
                                                                (usr?.mDays ??
                                                                        0) >
                                                                    0) ...[
                                                              mangaController.isDownloadLoading[
                                                                          index] ==
                                                                      true
                                                                  ? const CupertinoActivityIndicator()
                                                                  : GestureDetector(
                                                                      onTap: () =>
                                                                          mangaController
                                                                              .downloadChapter(index),
                                                                      child: const Icon(
                                                                          Icons
                                                                              .download),
                                                                    )
                                                            ],
                                                          ],
                                                        ),
                                                      ),
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        extendBody: true,
        bottomNavigationBar: mangaController.lastChapterId.value <= 0
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  if (!AppDatabase().isLoggedIn()) {
                    Get.snackbar("Алдаа", "Нэвтэрсэний дараа унших боломжтой");
                    Get.offAllNamed("/home", arguments: [3]);
                  } else {
                    if (mangaController.selectedManga.value.type == "premium") {
                      if ((usr?.mDays ?? 0) > 0 && (usr?.pDays ?? 0) > 0) {
                        Get.toNamed("/chapter-detail",
                            arguments: [mangaController.lastChapterId.value]);
                        mangaController.setChapterIndex(
                            mangaController.lastChapterIndex.value);
                      } else {
                        Get.snackbar("Алдаа",
                            "Premium эрхээ сунгаж байж унших боломжтой");
                        Get.offAllNamed("/home", arguments: [3]);
                      }
                    } else {
                      if ((usr?.mDays ?? 0) > 0) {
                        Get.toNamed("/chapter-detail",
                            arguments: [mangaController.lastChapterId.value]);
                        mangaController.setChapterIndex(
                            mangaController.lastChapterIndex.value);
                      } else {
                        Get.snackbar(
                            "Алдаа", "Эрхээ сунгаж байж унших боломжтой");
                        Get.offAllNamed("/home", arguments: [3]);
                      }
                    }
                  }
                },
                child: Container(
                  height: 40,
                  width: Get.width - 60,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Сүүлийн уншсан анги",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.4
                          ..color = Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
