import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrameController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxInt bottomIndex = 0.obs;
  setCustomIndex(int val) {
    bottomIndex.value = val;
  }
}
