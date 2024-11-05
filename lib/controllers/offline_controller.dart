import 'package:blade/configs/app_database.dart';
import 'package:blade/models/manga_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OfflineController extends GetxController {
  var containerHeight = 400.0.obs;
  var scrollController = ScrollController().obs;
  RxBool isLoading = true.obs;
  RxList<MangaModel?> data = RxList<MangaModel>();
  Rx<MangaModel> selectedManga = MangaModel().obs;
  RxBool isShow = false.obs;
  RxInt selectedChapterIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.value.addListener(_updateHeightOnScroll);
  }

  fetchData() async {
    data.clear();
    isLoading.value = true;
    data.addAll(await loadMangaListFromFile());
    isLoading.value = false;
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

  showToggle() {
    isShow.value = !isShow.value;
  }

  @override
  void dispose() {
    super.dispose();
    isLoading.value = true;
  }
}
