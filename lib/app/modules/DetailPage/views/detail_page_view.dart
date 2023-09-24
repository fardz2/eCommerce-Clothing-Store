import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';
import 'package:final_project/app/modules/home/ShoppingPage/controllers/shopping_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String product_id = Get.arguments;
    final HomePageController controllerHome = Get.find();
    final ShoppingPageController controllerCart = Get.find();
    final AuthController auth = Get.find();
    final items = controllerHome.detail(product_id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: SafeArea(
              top: true,
              child: Obx(() {
                bool isLiked = controllerHome.productlike.any((likedProduct) =>
                    likedProduct.product_id == items.product_id &&
                    likedProduct.user_id == auth.uid);
                return Column(
                  children: [
                    Stack(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(items.image),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 25,
                                    offset: const Offset(
                                        1, 20), // changes position of shadow
                                  ),
                                ]),
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white)),
                                  child: const Icon(
                                    Icons.navigate_before,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 25,
                                    offset: const Offset(
                                        1, 20), // changes position of shadow
                                  ),
                                ]),
                                child: TextButton(
                                  onPressed: () {
                                    if (isLiked) {
                                      controllerHome
                                          .deletelikeproduct(items.product_id);
                                    } else {
                                      controllerHome
                                          .addlikeproduct(items.product_id);
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white)),
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            items.title,
                            style: GoogleFonts.encodeSans(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 25,
                                    offset: const Offset(
                                        1, 5), // changes position of shadow
                                  ),
                                ]),
                                child: TextButton(
                                  onPressed: () {
                                    controller.decrement();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white)),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 20,
                                    child: Center(
                                      child: Text("${controller.count.value}",
                                          style: GoogleFonts.encodeSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16))),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 25,
                                    offset: const Offset(
                                        1, 5), // changes position of shadow
                                  ),
                                ]),
                                child: TextButton(
                                  onPressed: () {
                                    controller.increment();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white)),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("5.00",
                              style: GoogleFonts.encodeSans(
                                  textStyle: const TextStyle(fontSize: 16))),
                          Text(
                            "(7.932 reviews)",
                            style: GoogleFonts.encodeSans(
                                textStyle: const TextStyle(fontSize: 16),
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ReadMoreText(
                        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                        trimLines: 3,
                        style: GoogleFonts.encodeSans(
                          textStyle:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        moreStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        lessStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more ...',
                        trimExpandedText: ' show less',
                        colorClickableText: Colors.black,
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Choose Size",
                                  style: GoogleFonts.encodeSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: controller.size.value == "S"
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "S",
                                        style: GoogleFonts.encodeSans(
                                            textStyle: TextStyle(
                                          fontSize: 16,
                                          color: controller.size.value != "S"
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                      )),
                                    ),
                                    onTap: () => controller.setSize("S"),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: controller.size.value == "M"
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text("M",
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    controller.size.value != "M"
                                                        ? Colors.black
                                                        : Colors.white,
                                              )))),
                                    ),
                                    onTap: () => controller.setSize("M"),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: controller.size.value == "L"
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text("L",
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    controller.size.value != "L"
                                                        ? Colors.black
                                                        : Colors.white,
                                              )))),
                                    ),
                                    onTap: () => controller.setSize("L"),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: controller.size.value == "XL"
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text("XL",
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: TextStyle(
                                                fontSize: 16,
                                                color: controller.size.value !=
                                                        "XL"
                                                    ? Colors.black
                                                    : Colors.white,
                                              )))),
                                    ),
                                    onTap: () => controller.setSize("XL"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Color",
                                  style: GoogleFonts.encodeSans(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: controller.color == "grey"
                                              ? Border.all(color: Colors.black)
                                              : Border.all(
                                                  color: Colors.transparent)),
                                    ),
                                    onTap: () => controller.setColor("grey"),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: controller.color == "black"
                                              ? Border.all(color: Colors.black)
                                              : Border.all(
                                                  color: Colors.transparent)),
                                    ),
                                    onTap: () => controller.setColor("black"),
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: controller.color == "brown"
                                              ? Border.all(color: Colors.black)
                                              : Border.all(
                                                  color: Colors.transparent)),
                                    ),
                                    onTap: () => controller.setColor("brown"),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(100)),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text("Add to Cart | ",
                                style: GoogleFonts.encodeSans(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    color: Colors.white)),
                            Text('\$ ${controller.count.value * items.price}',
                                style: GoogleFonts.encodeSans(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    color: Colors.white)),
                          ],
                        ),
                        onTap: () {
                          controllerCart.addCart(
                              items.product_id,
                              controller.size.value,
                              controller.color.value,
                              controller.count.value);
                          Get.back();
                          Get.snackbar("Cart", "Cart berhasil ditambah",
                              icon: const Icon(IconlyLight.add_user));
                        },
                      ),
                    ),
                  ],
                );
              }))),
    );
  }
}
