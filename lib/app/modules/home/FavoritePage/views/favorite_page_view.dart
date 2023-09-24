import 'package:final_project/app/data/model/Product.dart';
import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePageView extends GetView<HomePageController> {
  const FavoritePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Favorite",
          style: GoogleFonts.encodeSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.productlike.isEmpty
            ? const Center(
                child: Text("Favorite product is empty"),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      height: 20,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                itemCount: controller.productlike.length,
                itemBuilder: (BuildContext context, int index) {
                  Product productlike = controller
                      .detail(controller.productlike[index].product_id);
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(productlike.image)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productlike.title,
                                      style: GoogleFonts.encodeSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14))),
                                  Text(controller.product[index].category,
                                      style: GoogleFonts.encodeSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 10))),
                                  SizedBox(height: 21),
                                  Text('\$${productlike.price}',
                                      style: GoogleFonts.encodeSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14))),
                                ],
                              ),
                            ),
                          ]),
                          Center(
                              child: Container(
                            margin: const EdgeInsets.only(top: 15, right: 10),
                            height: 35,
                            width: 35,
                            child: TextButton(
                                onPressed: () {
                                  controller.deletelikeproduct(
                                      productlike.product_id);
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
                                            Colors.black)),
                                child: const Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          )),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/detail-page',
                          arguments: productlike.product_id);
                    },
                  );
                }),
      ),
    );
  }
}
