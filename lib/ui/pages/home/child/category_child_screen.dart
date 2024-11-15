import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blade/configs/globals.dart';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/manga_controller.dart';
import 'package:blade/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChildScreen extends StatelessWidget {
  const CategoryChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MangaController mangaController = Get.put(MangaController());
    mangaController.fetchCategoryList();
    return Obx(
      () => mangaController.isLoadingCategory.value
          ? const Center(
              child: CupertinoActivityIndicator(
                color: AppTheme.bg,
              ),
            )
          : isImage == 0 && Platform.isIOS
              ? ListView.builder(
                  itemCount: mangaController.categoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var manga = mangaController.categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed("/manga-list", arguments: [manga.id ?? 0]);
                      },
                      child: Container(
                        width: Get.width - 40,
                        height: 60,
                        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(manga.title ?? ""),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : GridView.builder(
                  itemCount: mangaController.categoryList.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    CategoryModel category =
                        mangaController.categoryList[index];
                    // Decode the base64 string into bytes
                    Uint8List imageBytes = base64Decode(category.image ?? "");
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed("/manga-list",
                            arguments: [category.id ?? 0]);
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.bg,
                              image: DecorationImage(
                                image: MemoryImage(
                                  imageBytes,
                                ),
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
                              category.title ?? "",
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
