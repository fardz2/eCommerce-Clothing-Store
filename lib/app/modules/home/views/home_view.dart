import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(children: [
          Obx(() => controller.widgetOptions[controller.SelectedIndex.value]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurStyle: BlurStyle.normal,
                      blurRadius: 25,
                      offset:
                          const Offset(1, -25), // changes position of shadow
                    ),
                  ]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Obx(
                    () => BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: Colors.white,
                      items: [
                        BottomNavigationBarItem(
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(controller.SelectedIndex.value == 0
                                ? IconlyBold.home
                                : IconlyLight.home),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(controller.SelectedIndex.value == 1
                                ? IconlyBold.buy
                                : IconlyLight.buy),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(controller.SelectedIndex.value == 2
                                ? IconlyBold.heart
                                : IconlyLight.heart),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(controller.SelectedIndex.value == 3
                                ? IconlyBold.profile
                                : IconlyLight.profile),
                          ),
                          label: 'Home',
                        ),
                      ],
                      currentIndex: controller.SelectedIndex.value,
                      onTap: (index) {
                        controller.setSelectedIndex(index);
                      },
                      backgroundColor: Colors.black,
                      unselectedItemColor: Colors.white,
                      elevation: 1,
                    ),
                  )),
            ),
          )
        ]),
      ),
    );
  }
}
