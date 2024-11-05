// Function to get the file path where the list will be saved
import 'dart:convert';
import 'dart:io';
import 'package:blade/models/manga_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import 'globals.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  final box = GetStorage();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  //////////////////////////////////////////////

  Future<void> saveUser(User user) async {
    await box.write('user', user.toJson());
  }

  Future<void> saveToken(String token) async {
    await box.write('token', token);
  }

  User? getUser() {
    return box.read('user') == null ? null : User.fromJson(box.read('user'));
  }

  Future<void> deleteData() async {
    tkn = '';
    usr = null;
    await box.remove('user');
    await box.remove('token');
    await box.remove('isLogin');
    await box.remove('days');
    await box.remove('otp');
    await eraseAllDownloads();
    await box.erase();
  }

  Future<void> updateUser() async {}

  String? getAccessToken() {
    return box.read('token');
  }

  bool isLoggedIn() {
    return box.hasData('user');
  }
}

Future<void> saveMangaListToFile(List<MangaModel> mangaList) async {
  try {
    // Get the directory where we can store the file
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path and name
    final file = File('${directory.path}/manga_list.json');

    // Convert the manga list to JSON
    List<Map<String, dynamic>> jsonList =
        mangaList.map((manga) => manga.toJson()).toList();
    String jsonString = jsonEncode(jsonList);

    // Write the JSON string to the file
    await file.writeAsString(jsonString);

    print('Manga list saved to file successfully!');
  } catch (e) {
    print('Error saving manga list: $e');
  }
}

Future<List<MangaModel>> loadMangaListFromFile() async {
  try {
    // Get the directory where the file is stored
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path and name
    final file = File('${directory.path}/manga_list.json');

    // Check if the file exists
    if (await file.exists()) {
      // Read the JSON string from the file
      String jsonString = await file.readAsString();

      // Decode the JSON string into a List of dynamic maps
      List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert each map to a MangaModel
      List<MangaModel> mangaList =
          jsonList.map((json) => MangaModel.fromJson(json)).toList();

      return mangaList;
    } else {
      print('File does not exist.');
      return [];
    }
  } catch (e) {
    print('Error loading manga list: $e');
    return [];
  }
}

// Method to erase all download files
Future<void> eraseAllDownloads() async {
  try {
    // Get the directory where the file is stored
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path and name
    final file = File('${directory.path}/manga_list.json');

    // Check if the file exists
    if (await file.exists()) {
      // Delete the file
      await file.delete();
      print('All download files erased successfully!');
    } else {
      print('No download files to erase.');
    }
  } catch (e) {
    print('Error erasing download files: $e');
  }
}
