import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController user = Get.find();

    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Welcome 👋",
                        style: GoogleFonts.encodeSans(
                            textStyle: const TextStyle(fontSize: 14)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${user.name}",
                        style: GoogleFonts.encodeSans(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/250?image=9"),
                    radius: 30,
                  )
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: TextField(
                    style: GoogleFonts.encodeSans(
                        textStyle: const TextStyle(fontSize: 14)),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(11),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, color: Colors.grey.withOpacity(0.5)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Search clothes',
                        prefixIcon: const Icon(Icons.search)),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 49,
                      width: 48,
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar("Sorry", "Coming soon");
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.black)),
                        child: const Icon(
                          IconlyLight.filter,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Obx(
            () => TabBar(
              labelPadding: const EdgeInsets.only(left: 10),
              isScrollable: true,
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: const EdgeInsets.only(right: 13, left: 13),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          color: controller.SelectedIndex.value == 0
                              ? Colors.black
                              : Colors.white),
                      child: Row(
                        children: [
                          Icon(IconlyLight.category,
                              color: controller.SelectedIndex.value == 0
                                  ? Colors.white
                                  : Colors.black),
                          Text(
                            'All Items',
                            style: GoogleFonts.encodeSans(
                                fontSize: 12,
                                color: controller.SelectedIndex.value == 0
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    )),
                Tab(
                    child: Container(
                  padding: const EdgeInsets.only(right: 13, left: 13),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.0, color: Colors.grey.withOpacity(0.5)),
                      color: controller.SelectedIndex.value == 1
                          ? Colors.black
                          : Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.checkroom,
                          color: controller.SelectedIndex.value == 1
                              ? Colors.white
                              : Colors.black),
                      Text(
                        'Dress',
                        style: GoogleFonts.encodeSans(
                            fontSize: 12,
                            color: controller.SelectedIndex.value == 1
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                )),
                Tab(
                    child: Container(
                  padding: const EdgeInsets.only(right: 13, left: 13),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.0, color: Colors.grey.withOpacity(0.5)),
                      color: controller.SelectedIndex.value == 2
                          ? Colors.black
                          : Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.school,
                          color: controller.SelectedIndex.value == 2
                              ? Colors.white
                              : Colors.black),
                      Text(
                        'Hat',
                        style: GoogleFonts.encodeSans(
                            fontSize: 12,
                            color: controller.SelectedIndex.value == 2
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                )),
                Tab(
                    child: Container(
                  padding: const EdgeInsets.only(right: 13, left: 13),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.0, color: Colors.grey.withOpacity(0.5)),
                      color: controller.SelectedIndex.value == 3
                          ? Colors.black
                          : Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.watch,
                          color: controller.SelectedIndex.value == 3
                              ? Colors.white
                              : Colors.black),
                      Text(
                        'Watch',
                        style: GoogleFonts.encodeSans(
                          fontSize: 12,
                          color: controller.SelectedIndex.value == 3
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
              controller: controller.controller,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (index) {
                controller.setSelectedIndex(index);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.controller,
              children: controller.widgetOptions,
            ),
          )
        ],
      ),
    );
  }
}
