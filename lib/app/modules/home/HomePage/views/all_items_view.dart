import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllItemsView extends GetView<HomePageController> {
  const AllItemsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 100),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: controller.product.map((item) {
                int index = controller.product
                    .indexWhere((items) => items.title == item.title);
                bool isLiked = controller.productlike.any((likedProduct) =>
                    likedProduct.product_id == item.product_id &&
                    likedProduct.user_id == auth.uid);

                return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          width: 154.0,
                          height: index % 2 == 0 ? 211.0 : 251,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.image)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.redAccent,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(top: 15, right: 10),
                            height: 35,
                            width: 35,
                            child: TextButton(
                              onPressed: () {
                                if (isLiked) {
                                  controller.deletelikeproduct(item.product_id);
                                } else {
                                  controller.addlikeproduct(item.product_id);
                                }
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black)),
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        width: 150.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: GoogleFonts.encodeSans(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(item.category,
                                style: GoogleFonts.encodeSans(
                                    textStyle: const TextStyle(
                                        fontSize: 10, color: Colors.grey))),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$${item.price}',
                                    style: GoogleFonts.encodeSans(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14))),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text("5.00",
                                        style: GoogleFonts.encodeSans(
                                            textStyle:
                                                const TextStyle(fontSize: 12)))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/detail-page', arguments: item.product_id);
                  },
                );
              }).toList(),
            ),
          ),
        ));
  }
}
