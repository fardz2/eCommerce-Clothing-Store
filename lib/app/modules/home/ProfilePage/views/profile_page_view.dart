import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({Key? key}) : super(key: key);
  final AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.encodeSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                auth.logout();
                Get.offAllNamed(Routes.LOGIN);
              },
              child: const Text("logout")),
        ]),
      ),
    );
  }
}
