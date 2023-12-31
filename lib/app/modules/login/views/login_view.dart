import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/modules/login/controllers/login_controller.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.encodeSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!controller.isLoading.value) {
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      controller.isLoading.value = true;
                      Map<String, dynamic> hasil =
                          await authC.login(email.text, password.text);
                      controller.isLoading.value = false;
                      if (hasil["error"] == true) {
                        Get.snackbar("error", hasil["message"]);
                      } else {
                        Get.offAllNamed(Routes.HOME);
                      }
                    } else {
                      Get.snackbar("error", "email dan password harus diisi");
                    }
                  }
                },
                child: Obx(() => controller.isLoading.value
                    ? const Text("Loading")
                    : const Text("Login"))),
            ElevatedButton(
                onPressed: () => Get.toNamed("/register"),
                child: const Text("register"))
          ],
        ),
      ),
    );
  }
}
