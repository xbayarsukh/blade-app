import 'dart:convert';
import 'dart:typed_data';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/manga_controller.dart';
import 'package:blade/models/manga_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MangaListScreen extends StatelessWidget {
  MangaListScreen({required this.id, super.key});
  int id;

  @override
  Widget build(BuildContext context) {
    MangaController mangaController = Get.put(MangaController());
    mangaController.fetchMangaList(id);
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => mangaController.isLoadingMangaList.value
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppTheme.bg,
                ),
              )
            : mangaController.mangaList.isEmpty
                ? const Center(
                    child: Text(
                      "Энэ төрөлд Манга олдсонгүй.",
                    ),
                  )
                : GridView.builder(
                    itemCount: mangaController.mangaList.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      MangaModel manga = mangaController.mangaList[index];
                      Uint8List decodeImageByte =
                          base64Decode(manga.image ?? "");
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/manga-detail", arguments: [manga.id]);
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  decodeImageByte, // Uint8List (base64 decoding) байх ёстой
                                  fit: BoxFit.cover,
                                  gaplessPlayback:
                                      true, // Анивчилтаас сэргийлэх
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
                                manga.title ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
