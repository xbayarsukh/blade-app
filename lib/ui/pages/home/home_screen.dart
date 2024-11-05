import 'package:blade/configs/app_database.dart';
import 'package:blade/controllers/frame_controller.dart';
import 'package:blade/ui/pages/home/child/category_child_screen.dart';
import 'package:blade/ui/pages/home/child/download/download_child_screen.dart';
import 'package:blade/ui/pages/home/child/home_child_screen.dart';
import 'package:blade/ui/pages/home/child/user_child_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../configs/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({this.customIndex = 0, super.key});
  int customIndex;

  @override
  Widget build(BuildContext context) {
    FrameController frameController = Get.put(FrameController());
    frameController.setCustomIndex(customIndex);
    return Obx(
      () => Scaffold(
        backgroundColor: AppTheme.dark,
        appBar: frameController.bottomIndex.value == 0
            ? AppBar(
                backgroundColor: AppTheme.dark,
                automaticallyImplyLeading: false,
                // title: Container(
                //   height: 45,
                //   margin: const EdgeInsets.only(bottom: 10),
                //   padding: const EdgeInsets.only(),
                //   decoration: BoxDecoration(
                //     color: AppTheme.gray,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: TextField(
                //     controller: frameController.searchController.value,
                //     decoration: const InputDecoration(
                //       border: InputBorder.none,
                //       prefixIcon: Icon(
                //         Icons.search,
                //         color: AppTheme.bg,
                //       ),
                //       fillColor: AppTheme.bg,
                //       iconColor: AppTheme.bg,
                //       focusColor: AppTheme.bg,
                //       hoverColor: AppTheme.bg,
                //       prefixIconColor: AppTheme.bg,
                //       suffixIconColor: AppTheme.bg,
                //       hintText: "Нэрээр хайх .....",
                //     ),
                //     style: const TextStyle(
                //       color: AppTheme.bg,
                //       fontSize: 18,
                //     ),
                //     cursorColor: AppTheme.bg,
                //   ),
                // ),
                title: const Text("Blade Manga"),
              )
            : frameController.bottomIndex.value == 1
                ? AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: AppTheme.dark,
                    title: const Text(
                      "Төрөл",
                      textAlign: TextAlign.center,
                    ),
                  )
                : frameController.bottomIndex.value == 2
                    ? AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: AppTheme.dark,
                        title: const Text(
                          "Татсан файл",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: AppTheme.dark,
                        title: Text(
                          AppDatabase().isLoggedIn() ? "Хэрэглэгч" : "",
                          textAlign: TextAlign.center,
                        ),
                      ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: [
            const HomeChildScreen(),
            const CategoryChildScreen(),
            const DownloadChildScreen(),
            const UserChildScreen(),
          ][frameController.bottomIndex.value],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          decoration: const BoxDecoration(
            color: AppTheme.dark,
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightGray,
                offset: Offset(0, 0),
                blurRadius: .1,
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ...List.generate(
              4,
              (index) => InkWell(
                onTap: () {
                  frameController.bottomIndex.value = index;
                  customIndex = index;
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 30) * .18,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.home
                            : index == 1
                                ? Icons.category
                                : index == 2
                                    ? Icons.download
                                    : Icons.person,
                        color: frameController.bottomIndex.value == index
                            ? AppTheme.gray
                            : AppTheme.bg,
                        size: 20,
                      ),
                      Text(
                        index == 0
                            ? "Нүүр"
                            : index == 1
                                ? "Төрөл"
                                : index == 2
                                    ? "Татсан"
                                    : "Хэрэглэгч",
                        style: TextStyle(
                          color: frameController.bottomIndex.value == index
                              ? AppTheme.gray
                              : AppTheme.bg,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
