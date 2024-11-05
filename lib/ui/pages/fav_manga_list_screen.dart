import 'dart:convert';
import 'dart:typed_data';
import 'package:blade/models/manga_model.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/manga_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavMangaListScreen extends StatefulWidget {
  const FavMangaListScreen({super.key});

  @override
  State<FavMangaListScreen> createState() => _FavMangaListScreenState();
}

class _FavMangaListScreenState extends State<FavMangaListScreen> {
  List<MangaModel> mangaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMangas();
  }

  fetchMangas() async {
    isLoading = true;
    setStates();
    ResponseModel response = await MangaRepositories().favMangas();
    if (response.status == 200 && response.success == true) {
      mangaList.addAll(List<MangaModel>.from(
          response.data.map((x) => MangaModel.fromJson(x))));
      isLoading = false;
      setStates();
    }
  }

  setStates() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Таалагдсан"),
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : GridView.builder(
              itemCount: mangaList.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 6,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                MangaModel manga = mangaList[index];
                Uint8List decodeImageByte = base64Decode(manga.image ?? "");
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
                            gaplessPlayback: true, // Анивчилтаас сэргийлэх
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
    );
  }
}
