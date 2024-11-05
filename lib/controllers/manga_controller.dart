import 'package:blade/configs/app_database.dart';
import 'package:blade/models/category_model.dart';
import 'package:blade/models/chapter_model.dart';
import 'package:blade/models/manga_model.dart';
import 'package:blade/repositories/manga_repositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configs/globals.dart';
import '../models/response_model.dart';

class MangaController extends GetxController {
  var containerHeight = 400.0.obs;
  var scrollController = ScrollController().obs;
  RxBool isLoadingMangaList = true.obs;
  RxList<MangaModel> mangaList = <MangaModel>[].obs;
  RxBool isLoadingDetail = true.obs;
  RxBool isLoadingChapter = true.obs;
  RxBool isLoadingCategory = true.obs;
  RxBool isLoadingFav = false.obs;
  RxInt isFav = 0.obs;
  Rx<MangaModel> selectedManga = MangaModel().obs;
  Rx<ChapterModel> selectedChapter = ChapterModel().obs;
  RxBool isShow = false.obs;
  RxInt selectedChapterIndex = 0.obs;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<bool> downloadStatusList = <bool>[].obs;
  RxBool isDownloading =
      false.obs; // Add this flag to track the download status
  RxList<bool> isDownloadLoading = <bool>[].obs;
  RxBool isSendLoading = false.obs;
  RxInt lastChapterId = 0.obs;
  RxInt lastChapterIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.value.addListener(_updateHeightOnScroll);
  }

  fetchCategoryList() async {
    isLoadingCategory.value = true;
    ResponseModel response = await MangaRepositories().getCategories();
    if (response.status == 200 && response.success == true) {
      categoryList.clear();
      categoryList.value = List<CategoryModel>.from(
          response.data.map((x) => CategoryModel.fromJson(x)));
      isLoadingCategory.value = false;
    }
  }

  fetchDetail(id) async {
    isLoadingDetail.value = true;
    ResponseModel response = await MangaRepositories().detailManga(id);
    if (response.status == 200 && response.success == true) {
      isDownloadLoading.clear();
      selectedManga.value = MangaModel.fromJson(response.data);
      isFav.value = selectedManga.value.isfavourite ?? 0;
      lastChapterId.value = selectedManga.value.lastChapterId ?? 0;
      lastChapterIndex.value = selectedManga.value.chapters!
          .indexWhere((test) => test.id == lastChapterId.value);
      await fetchDownloadStatuses();
      isLoadingDetail.value = false;
    }
  }

  setSendLoad() {
    isSendLoading.value = !isSendLoading.value;
  }

  fetchMangaList(id) async {
    isLoadingMangaList.value = true;
    ResponseModel response = await MangaRepositories().getCategoryManga(id);
    if (response.status == 200 && response.success == true) {
      mangaList.clear();
      mangaList.value = List<MangaModel>.from(
          response.data.map((x) => MangaModel.fromJson(x)));
      isLoadingMangaList.value = false;
    }
  }

  updateFav(id, status) async {
    isLoadingFav.value = true;
    ResponseModel response =
        await MangaRepositories().updateFavourite(id, status);
    if (response.status == 200 && response.success == true) {
      selectedManga.value.isfavourite = response.data;
      isFav.value = response.data;
      isLoadingFav.value = false;
    }
  }

  fetchChapter(id) async {
    isLoadingChapter.value = true;
    ResponseModel response =
        await MangaRepositories().chapterDetail(id, selectedManga.value.id);
    selectedChapter = ChapterModel().obs;
    if (!AppDatabase().isLoggedIn()) {
      Get.snackbar("Алдаа", "Нэвтэрсэний дараа унших боломжтой");
      Get.offAllNamed("/home", arguments: [3]);
    }
    if (response.status == 200 && response.success == true) {
      selectedChapter.value =
          ChapterModel.fromJson(response.data, selectedManga.value.image ?? "");
      isLoadingChapter.value = false;
    }
  }

  showToggle() {
    isShow.value = !isShow.value;
  }

  setChapterIndex(int val) {
    selectedChapterIndex.value = val;
  }

  setIsDownloading(index, val) {
    isDownloadLoading[index] = val;
  }

  Future<void> downloadChapter(int index) async {
    if ((usr?.mDays ?? 0) > 0) {
      if (isDownloading.value) {
        Get.snackbar("Түр хүлээнэ үү", "Татаж байна...");
        return; // Exit if a download is already in progress
      }
      setIsDownloading(index, true);

      isDownloading.value = true; // Set the flag to true when download starts

      List<MangaModel>? mangaList = await loadMangaListFromFile();
      MangaModel selectedMangaa = selectedManga.value;

      int sIndex =
          mangaList.indexWhere((manga) => manga.id == selectedMangaa.id);

      // Check if the chapter is already downloaded
      if (sIndex != -1 &&
          mangaList[sIndex].chapters?.any((chapter) =>
                  chapter.id == selectedMangaa.chapters?[index].id) ==
              true) {
        Get.snackbar("Сануулга", "Энэ бүлгийг татсан байна");
        isDownloading.value = false; // Reset the flag
        setIsDownloading(index, false);
        return;
      }

      ResponseModel response = await MangaRepositories().chapterDetail(
          selectedMangaa.chapters?[index].id ?? 0, selectedManga.value.id);
      if (response.status == 200 && response.success == true) {
        ChapterModel downloadChapter = ChapterModel.fromJson(
          response.data,
          selectedMangaa.image ?? "",
        );

        if (sIndex != -1) {
          mangaList[sIndex].chapters ??= [];
          mangaList[sIndex].chapters?.add(downloadChapter);
        } else {
          selectedMangaa.chapters ??= [];
          selectedMangaa.chapters!.clear();
          selectedMangaa.chapters?.add(downloadChapter);
          mangaList.add(selectedMangaa);
        }

        await saveMangaListToFile(mangaList).then(
          (onValue) async {
            await fetchDownloadStatuses();
            Get.snackbar("Амжилттай", "Татагдлаа");
            setIsDownloading(index, false);
          },
        );
      }

      isDownloading.value = false; // Reset the flag after download completes
    } else {
      Get.snackbar("Алдаа", "Эрхээ сунгаж байж татах боломжтой");
      Get.offAllNamed("/home", arguments: [3]);
    }
  }

  Future<void> fetchDownloadStatuses() async {
    final mangaList = await loadMangaListFromFile();
    final currentManga = selectedManga.value;

    for (var chapter in currentManga.chapters!) {
      bool isDownloaded = mangaList.any((manga) =>
          manga.id == currentManga.id &&
          manga.chapters!.any((c) => c.id == chapter.id));
      downloadStatusList.add(isDownloaded);
    }
  }

  @override
  void onClose() {
    scrollController.value.removeListener(_updateHeightOnScroll);
    scrollController.value.dispose();
    super.onClose();
  }

  void _updateHeightOnScroll() {
    double maxHeight = Get.context!.mediaQuery.size.height - 240;

    // Update the height based on the scroll position
    containerHeight.value = 400 +
        (scrollController.value.offset /
                scrollController.value.position.maxScrollExtent) *
            (maxHeight - 400);

    // Clamp the value between 400 and maxHeight
    containerHeight.value = containerHeight.value.clamp(400.0, maxHeight);
  }
}
