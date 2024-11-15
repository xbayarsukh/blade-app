import 'dart:async';

import 'package:blade/models/manga_model.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/models/slide_model.dart';
import 'package:blade/repositories/manga_repositories.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<CarouselSliderController> carouselController =
      CarouselSliderController().obs;
  RxList imgList = [
    "https://gg.asuracomic.net/storage/media/247/conversions/01J3BARKNDAGY0QC9R4DSMPXET-optimized.webp",
  ].obs;
  RxInt current = 0.obs;
  RxList<SlideModel> slideMangaList = <SlideModel>[].obs;
  RxBool isSlideManga = true.obs;
  RxList<MangaModel> newMangaList = <MangaModel>[].obs;
  RxBool isNewManga = true.obs;
  RxList<MangaModel> ongoingMangaList = <MangaModel>[].obs;
  RxBool isOngoingManga = true.obs;
  RxList<MangaModel> finishMangaList = <MangaModel>[].obs;
  RxBool isFinishManga = true.obs;
  RxList<MangaModel> premiumMangaList = <MangaModel>[].obs;
  RxBool isPremiumManga = true.obs;
  StreamSubscription<List<ConnectivityResult>>? subscription;
  RxBool connectionStatus = true.obs;

  setCarouselCurrent(int index) {
    current.value = index;
  }

  fetchData() async {
    await fetchSlide();
    await fetchNew();
    await fetchOngoing();
    await fetchFinish();
    await fetchPremium();
  }

  Future<void> fetchSlide() async {
    isSlideManga.value = true;
    ResponseModel slideresponse = await MangaRepositories().slideManga();
    if (slideresponse.status == 200 && slideresponse.success == true) {
      slideMangaList.value = List<SlideModel>.from(
          slideresponse.data.map((x) => SlideModel.fromJson(x)));
      isSlideManga.value = false;
    }
  }

  Future<void> fetchNew() async {
    isNewManga.value = true;
    ResponseModel newresponse = await MangaRepositories().newManga();
    if (newresponse.status == 200 && newresponse.success == true) {
      newMangaList.value = List<MangaModel>.from(
          newresponse.data.map((x) => MangaModel.fromJson(x)));
      isNewManga.value = false;
    }
  }

  Future<void> fetchOngoing() async {
    isOngoingManga.value = true;
    ResponseModel ongoingresponse = await MangaRepositories().ongoingManga();
    if (ongoingresponse.status == 200 && ongoingresponse.success == true) {
      ongoingMangaList.value = List<MangaModel>.from(
          ongoingresponse.data.map((x) => MangaModel.fromJson(x)));
      isOngoingManga.value = false;
    }
  }

  Future<void> fetchFinish() async {
    isFinishManga.value = true;
    ResponseModel finishresponse = await MangaRepositories().finishManga();
    if (finishresponse.status == 200 && finishresponse.success == true) {
      finishMangaList.value = List<MangaModel>.from(
          finishresponse.data.map((x) => MangaModel.fromJson(x)));
      isFinishManga.value = false;
    }
  }

  Future<void> fetchPremium() async {
    isPremiumManga.value = true;
    ResponseModel premiumresponse = await MangaRepositories().premiumManga();
    if (premiumresponse.status == 200 && premiumresponse.success == true) {
      premiumMangaList.value = List<MangaModel>.from(
          premiumresponse.data.map((x) => MangaModel.fromJson(x)));
      isPremiumManga.value = false;
    }
  }

  

  @override
  void onInit() {
    super.onInit();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
        connectionStatus.value = true;
      } else if (result.contains(ConnectivityResult.wifi)) {
        connectionStatus.value = true;
      } else if (result.contains(ConnectivityResult.vpn)) {
        connectionStatus.value = true;
      } else if (result.contains(ConnectivityResult.other)) {
        connectionStatus.value = false;
      } else if (result.contains(ConnectivityResult.none)) {
        connectionStatus.value = false;
      } else {
        connectionStatus.value = false;
      }

      if (connectionStatus.value == false) {
        Get.offAllNamed('/splash');
      }
    });
  }
}
