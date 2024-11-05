import 'package:blade/models/chapter_model.dart';
import 'package:blade/models/manga_model.dart';
import 'package:blade/models/membership_model.dart';
import 'package:blade/ui/pages/about_screen.dart';
import 'package:blade/ui/pages/chapter_detail_screen.dart';
import 'package:blade/ui/pages/fav_manga_list_screen.dart';
import 'package:blade/ui/pages/home/child/download/offline_chapter_screen.dart';
import 'package:blade/ui/pages/home/child/download/offline_manga_screen.dart';
import 'package:blade/ui/pages/home/home_screen.dart';
import 'package:blade/ui/pages/manga_detail_screen.dart';
import 'package:blade/ui/pages/category_manga_list_screen.dart';
import 'package:blade/ui/pages/membership_detail_screen.dart';
import 'package:blade/ui/pages/membership_screen.dart';
import 'package:blade/ui/pages/notification_screen.dart';
import 'package:blade/ui/pages/offline_screen.dart';
import 'package:blade/ui/splash_screen.dart';
import 'package:get/route_manager.dart';

List<GetPage> routes = [
  GetPage(name: "/splash", page: () => const SplashScreen()),
  GetPage(
    name: "/home",
    page: () => HomeScreen(
      customIndex: Get.arguments?[0] ?? 0,
    ),
  ),
  GetPage(
    name: "/manga-detail",
    page: () => MangaDetailScreen(
      id: Get.arguments?[0] ?? 0,
    ),
  ),
  GetPage(
    name: "/chapter-detail",
    page: () => ChapterDetailScreen(
      id: Get.arguments?[0] ?? 0,
    ),
  ),
  GetPage(
    name: "/manga-list",
    page: () => MangaListScreen(
      id: Get.arguments?[0] ?? 0,
    ),
  ),

  //offline pages
  GetPage(name: "/offline-screen", page: () => const OfflineScreen()),
  GetPage(
    name: "/offline-manga-detail",
    page: () => OfflineMangaScreen(
      manga: Get.arguments?[0] ?? MangaModel(),
    ),
  ),
  GetPage(
    name: "/offline-chapter-detail",
    page: () => OfflineChapterScreen(
      chapter: Get.arguments?[0] ?? ChapterModel(),
    ),
  ),
  GetPage(name: "/fav-screen", page: () => const FavMangaListScreen()),
  GetPage(name: "/membership-screen", page: () => const MembershipScreen()),
  GetPage(name: "/notification-screen", page: () => const NotificationScreen()),
  GetPage(
    name: "/membership-detail",
    page: () => MembershipDetailScreen(
      membershipModel: Get.arguments?[0] ?? MembershipModel(),
    ),
  ),
  GetPage(name: "/about-screen", page: () => const AboutScreen()),
];
