import 'dart:convert';

import 'package:blade/configs/globals.dart';
import 'package:blade/controllers/home_controller.dart';
import 'package:blade/models/manga_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../configs/theme/theme.dart';

class HomeChildScreen extends StatelessWidget {
  const HomeChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController frameController = Get.put(HomeController());
    frameController.fetchData();
    return Obx(
      () => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (frameController.isSlideManga.value == false &&
                  frameController.slideMangaList.isNotEmpty) ...[
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        onPageChanged: (index, reason) {
                          frameController.setCarouselCurrent(index);
                        },
                      ),
                      carouselController:
                          frameController.carouselController.value,
                      items: frameController.slideMangaList.map((i) {
                        Uint8List slideImage = base64Decode(i.image ?? "");
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                frameController.goDetail(i.mangaId);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    slideImage, // Uint8List (base64 decoding) байх ёстой
                                    fit: BoxFit.cover,
                                    gaplessPlayback:
                                        true, // Анивчилтаас сэргийлэх
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 0,
                      left: (Get.width -
                              ((12 + 8) * frameController.imgList.length)) /
                          2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: frameController.imgList
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => frameController
                                .carouselController.value
                                .animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white)
                                    .withOpacity(
                                        frameController.current.value ==
                                                entry.key
                                            ? 0.9
                                            : 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ] else if (frameController.isSlideManga.value == true) ...[
                const SizedBox(
                  height: 200,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: AppTheme.bg,
                    ),
                  ),
                )
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Шинээр нэмэгдсэн",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ).padding(left: 20, top: 10),
                  SizedBox(
                    height: 180,
                    child: frameController.isNewManga.value
                        ? const Center(
                            child: CupertinoActivityIndicator(
                            color: AppTheme.bg,
                          ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: frameController.newMangaList.length,
                            itemBuilder: (context, index) {
                              MangaModel newManga =
                                  frameController.newMangaList[index];
                              Uint8List newImage =
                                  base64Decode(newManga.image ?? "");
                              return GestureDetector(
                                onTap: () {
                                  frameController.goDetail(newManga.id);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 130,
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 20 : 10,
                                        right: (index == 10 - 1) ? 20 : 0,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.memory(
                                          newImage, // Uint8List (base64 decoding) байх ёстой
                                          fit: BoxFit.cover,
                                          gaplessPlayback:
                                              true, // Анивчилтаас сэргийлэх
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: index == 0 ? 20 : 10,
                                      bottom: 0,
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 130,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.gray,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: Text(
                                          newManga.lastEpisode ?? "",
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ).padding(top: 10)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Гарч байгаа",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ).padding(left: 20, top: 10),
                  SizedBox(
                    height: 180,
                    child: frameController.isOngoingManga.value
                        ? const Center(
                            child: CupertinoActivityIndicator(
                            color: AppTheme.bg,
                          ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: frameController.ongoingMangaList.length,
                            itemBuilder: (context, index) {
                              MangaModel ongoingManga =
                                  frameController.ongoingMangaList[index];
                              Uint8List ongoingImage =
                                  base64Decode(ongoingManga.image ?? "");
                              return GestureDetector(
                                onTap: () {
                                  frameController.goDetail(ongoingManga.id);
                                },
                                child: Container(
                                  height: 180,
                                  width: 130,
                                  margin: EdgeInsets.only(
                                    left: index == 0 ? 20 : 10,
                                    right: (index == 10 - 1) ? 20 : 0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      ongoingImage, // Uint8List (base64 decoding) байх ёстой
                                      fit: BoxFit.cover,
                                      gaplessPlayback:
                                          true, // Анивчилтаас сэргийлэх
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ).padding(top: 10)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Гарч дууссан",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ).padding(left: 20, top: 10),
                  SizedBox(
                    height: 180,
                    child: frameController.isFinishManga.value
                        ? const Center(
                            child: CupertinoActivityIndicator(
                            color: AppTheme.bg,
                          ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: frameController.finishMangaList.length,
                            itemBuilder: (context, index) {
                              MangaModel finishManga =
                                  frameController.finishMangaList[index];
                              Uint8List finishImage =
                                  base64Decode(finishManga.image ?? "");
                              return GestureDetector(
                                onTap: () {
                                  frameController.goDetail(finishManga.id);
                                },
                                child: Container(
                                  height: 180,
                                  width: 130,
                                  margin: EdgeInsets.only(
                                    left: index == 0 ? 20 : 10,
                                    right: (index == 10 - 1) ? 20 : 0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      finishImage, // Uint8List (base64 decoding) байх ёстой
                                      fit: BoxFit.cover,
                                      gaplessPlayback:
                                          true, // Анивчилтаас сэргийлэх
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ).padding(top: 10)
                ],
              ),
              if (usr != null && (usr?.mDays ?? 0) > 0 && (usr?.pDays ?? 0) > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Premium",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ).padding(left: 20, top: 10),
                    SizedBox(
                      height: 180,
                      child: frameController.isPremiumManga.value
                          ? const Center(
                              child: CupertinoActivityIndicator(
                              color: AppTheme.bg,
                            ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  frameController.premiumMangaList.length,
                              itemBuilder: (context, index) {
                                MangaModel premiumManga =
                                    frameController.premiumMangaList[index];
                                Uint8List premiumImage =
                                    base64Decode(premiumManga.image ?? "");
                                return GestureDetector(
                                  onTap: () {
                                    frameController.goDetail(premiumManga.id);
                                  },
                                  child: Container(
                                    height: 180,
                                    width: 130,
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 20 : 10,
                                      right: (index == 10 - 1) ? 20 : 0,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(
                                        premiumImage, // Uint8List (base64 decoding) байх ёстой
                                        fit: BoxFit.cover,
                                        gaplessPlayback:
                                            true, // Анивчилтаас сэргийлэх
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ).padding(top: 10)
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
