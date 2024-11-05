import 'package:blade/configs/app_database.dart';
import 'package:blade/models/login_response.dart';
import 'package:blade/models/response_model.dart';
import 'package:blade/repositories/auth_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../configs/globals.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString page = "login".obs;
  RxString otpType = "register".obs;
  RxString validOtp = "".obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  Rx<TextEditingController> password2Controller = TextEditingController().obs;
  RxInt dayM = 0.obs;
  RxInt dayP = 0.obs;
  RxBool isLogged = false.obs;

  changePage(String val, {bool isReset = false}) {
    page.value = val;
    if (isReset) {
      emailController.value.text = "";
      nameController.value.text = "";
      passwordController.value.text = "";
      password2Controller.value.text = "";
      otpController.value.text = "";
    }
  }

  changeOtpType(String val) {
    otpType.value = val;
    dayM.value = usr?.mDays ?? 0;
    dayP.value = usr?.pDays ?? 0;
  }

  login() async {
    isLoading.value = true;
    LoginResponse response = await AuthRepositories()
        .login(emailController.value.text, passwordController.value.text);
    if (response.status == 200 && response.success == true) {
      usr = response.user;
      tkn = response.token;
      await AppDatabase().saveToken(response.token!);
      await AppDatabase().saveUser(response.user!);
      isLoading.value = false;
      emailController.value.text = "";
      passwordController.value.text = "";
      check();
    } else {
      Get.snackbar("Алдаа", response.message ?? "");
      isLoading.value = false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null; // Email is valid
  }

  sendOtp(bool isRegister) async {
    isLoading.value = true;
    ResponseModel response = await AuthRepositories()
        .getOtp(emailController.value.text, isRegister: isRegister);
    if (response.status == 200 && response.success == true) {
      validOtp.value = response.data["otp_code"].toString();
      isLoading.value = false;
      if (!isRegister) {
        changePage("otp");
        changeOtpType("forgot");
      } else {
        changePage("otp");
        changeOtpType("register");
      }
      Get.snackbar("Амжилттай",
          "Амжилттай илгээгдлээ. Зарим тохиолдол Spam дотор очсон байх боломжтойг анхаарна уу.");
    } else {
      Get.snackbar("Алдаа", response.message ?? "");
      isLoading.value = false;
    }
  }

  sendMyInfo() async {
    isLoading.value = true;
    if (passwordController.value.text == password2Controller.value.text) {
      ResponseModel response = await AuthRepositories().register(
        emailController.value.text,
        otpController.value.text,
        passwordController.value.text,
        nameController.value.text,
      );
      if (response.status == 200 && response.success == true) {
        emailController.value.text = "";
        otpController.value.text = "";
        passwordController.value.text = "";
        nameController.value.text = "";
        Get.snackbar("Амжилттай", response.message ?? "");
        isLoading.value = false;
        changePage("login", isReset: true);
        changeOtpType("register");
      } else {
        Get.snackbar("Алдаа", response.message ?? "");
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Алдаа", "Нүүц үг таарахгүй байна");
      isLoading.value = false;
    }
  }

  forgotPass() async {
    isLoading.value = true;
    if (passwordController.value.text == password2Controller.value.text) {
      ResponseModel response = await AuthRepositories().register(
        emailController.value.text,
        otpController.value.text,
        passwordController.value.text,
        nameController.value.text,
      );
      if (response.status == 200 && response.success == true) {
        emailController.value.text = "";
        otpController.value.text = "";
        passwordController.value.text = "";
        nameController.value.text = "";
        Get.snackbar("Амжилттай", response.message ?? "");
        isLoading.value = false;
        changePage("login", isReset: true);
        changeOtpType("register");
      } else {
        Get.snackbar("Алдаа", response.message ?? "");
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Алдаа", "Нүүц үг таарахгүй байна");
      isLoading.value = false;
    }
  }

  check() {
    isLogged.value = AppDatabase().isLoggedIn();
  }

  logout() async {
    page.value = "login";
    await AppDatabase().deleteData();
    check();
  }
}
