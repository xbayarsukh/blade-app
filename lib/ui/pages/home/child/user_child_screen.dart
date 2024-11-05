import 'package:blade/configs/globals.dart';
import 'package:blade/configs/theme/theme.dart';
import 'package:blade/controllers/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class UserChildScreen extends StatelessWidget {
  const UserChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    profileController.check();
    profileController.changePage("login");
    return Obx(() => profileController.isLogged.value
        ? isLogged(profileController)
        : login(profileController));
  }
}

isLogged(ProfileController profileController) {
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(
            "https://banner2.cleanpng.com/20240204/xro/transparent-goku-illustration-of-goku-from-dragon-ball-1710886648944.webp",
          ),
        ).padding(vertical: 10),
        Text(
          "${usr?.name} ID: ${usr?.id}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 10),
        if ((usr?.mDays ?? 0) >= 0)
          Text("Үйлчилгээний хоног: ${usr?.mDays ?? 0}"),
        if ((usr?.pDays ?? 0) > 0)
          Text("Тусгай эрхийн хоног: ${usr?.pDays ?? 0}"),
        // Text("Тусгай эрхийн хоног: 10"),
        GestureDetector(
          onTap: () {
            Get.toNamed('/notification-screen');
          },
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.bell_fill,
                  color: AppTheme.bg,
                  size: 26,
                ).padding(right: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Мэдэгдэл",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Танд ирсэн мэдэгдэл"),
                  ],
                ),
              ],
            ),
          ).padding(horizontal: 20, top: 14),
        ),

        GestureDetector(
          onTap: () {
            Get.toNamed('/fav-screen');
          },
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.heart_fill,
                  color: AppTheme.bg,
                  size: 26,
                ).padding(right: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Таалагдсан",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Таалагдсан манганы жагсаалт"),
                  ],
                ),
              ],
            ),
          ).padding(horizontal: 20, top: 14),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/membership-screen');
          },
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.star_fill,
                  color: AppTheme.bg,
                  size: 26,
                ).padding(right: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Үйлчилгээний эрх",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Хэрхэн эрх авах заавар"),
                  ],
                ),
              ],
            ),
          ).padding(horizontal: 20, top: 14),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/about-screen');
          },
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.info_circle_fill,
                  color: AppTheme.bg,
                  size: 26,
                ).padding(right: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Бидний тухай",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Апп болон багын талаар"),
                  ],
                ),
              ],
            ),
          ).padding(horizontal: 20, top: 14),
        ),
        GestureDetector(
          onTap: () {
            profileController.logout();
          },
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  Icons.logout_outlined,
                  color: AppTheme.bg,
                  size: 26,
                ).padding(right: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Гарах",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Системээс гарах"),
                  ],
                ),
              ],
            ),
          ).padding(horizontal: 20, top: 14),
        )
      ],
    ),
  );
}

login(ProfileController profileController) {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: [
        if (profileController.isLoading.value) ...[
          const Center(
            child: CupertinoActivityIndicator(
              color: AppTheme.bg,
            ),
          )
        ] else ...[
          if (profileController.page.value == 'login') ...[
            const Text(
              "Нэвтрэх",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: profileController.emailController.value,
                validator: profileController.validateEmail,
                onTap: () {
                  return;
                },
                onChanged: (value) {
                  return;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Цахим хаяг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.passwordController.value,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нууц үг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    profileController.changePage("forgot", isReset: true);
                  },
                  child: const Text("Нууц үг сэргээх"),
                ),
              ],
            ).padding(top: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  profileController.login();
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("register", isReset: true);
                },
                child: const Text(
                  "Бүртгүүлэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ] else if (profileController.page.value == "register") ...[
            const Text(
              "Бүртгүүлэх",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: profileController.emailController.value,
                validator: profileController.validateEmail,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Цахим хаяг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  profileController.sendOtp(true);
                },
                child: const Text(
                  "Бүртгүүлэх",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("login", isReset: true);
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ] else if (profileController.page.value == "otp") ...[
            const Text(
              "Баталгаажуулах",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.otpController.value,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.password,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "OTP код",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  if (profileController.otpType.value == "register") {
                    if (profileController.validOtp.value ==
                        profileController.otpController.value.text) {
                      profileController.changePage("myInfo");
                    } else {
                      Get.snackbar("Алдаа", "Код буруу байна.");
                    }
                  } else {
                    if (profileController.validOtp.value ==
                        profileController.otpController.value.text) {
                      profileController.changePage("newPassword");
                    } else {
                      Get.snackbar("Алдаа", "Код буруу байна.");
                    }
                  }
                },
                child: const Text(
                  "Баталгаажуулах",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("login");
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ] else if (profileController.page.value == "forgot") ...[
            const Text(
              "Нууц үг сэргээх",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: profileController.emailController.value,
                validator: profileController.validateEmail,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Цахим хаяг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  profileController.sendOtp(false);
                },
                child: const Text(
                  "Нууц үг сэргээх",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("login", isReset: true);
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ] else if (profileController.page.value == "myInfo") ...[
            const Text(
              "Бүртгүүлэх",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.nameController.value,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нэр",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: profileController.emailController.value,
                validator: profileController.validateEmail,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Цахим хаяг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.passwordController.value,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нууц үг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.password2Controller.value,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нууц үг давтах",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  profileController.sendMyInfo();
                },
                child: const Text(
                  "Бүртгүүлэх",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("login", isReset: true);
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ] else if (profileController.page.value == "newPassword") ...[
            const Text(
              "Нууц үг сэргээх",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ).padding(top: 20),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.passwordController.value,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нууц үг",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                color: AppTheme.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: profileController.password2Controller.value,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppTheme.bg,
                  ),
                  fillColor: AppTheme.bg,
                  iconColor: AppTheme.bg,
                  focusColor: AppTheme.bg,
                  hoverColor: AppTheme.bg,
                  prefixIconColor: AppTheme.bg,
                  suffixIconColor: AppTheme.bg,
                  hintText: "Нууц үг давтах",
                ),
                style: const TextStyle(
                  color: AppTheme.bg,
                  fontSize: 18,
                ),
                cursorColor: AppTheme.bg,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                ),
                onPressed: () {
                  profileController.forgotPass();
                },
                child: const Text(
                  "Сэргээх",
                  style: TextStyle(fontSize: 16),
                ),
              ).padding(top: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius:
                          BorderRadius.circular(12), // Border radius 8
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  profileController.changePage("login", isReset: true);
                },
                child: const Text(
                  "Нэвтрэх",
                  style: TextStyle(fontSize: 16, color: AppTheme.bg),
                ),
              ).padding(top: 20),
            ),
          ]
        ]
      ],
    ).padding(horizontal: 20),
  );
}
