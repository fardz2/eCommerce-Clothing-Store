import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(HomePageController());
  }
}
