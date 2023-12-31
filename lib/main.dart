import 'package:final_project/app/controllers/auth_controller.dart';

import 'package:final_project/app/modules/LoadingScreen/LoadingScreen.dart';

import 'package:final_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapAuth) {
          if (snapAuth.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute: snapAuth.hasData ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        });
  }
}
