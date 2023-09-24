import 'package:final_project/app/data/model/Product.dart';
import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../controllers/shopping_page_controller.dart';

class ShoppingPageView extends GetView<ShoppingPageController> {
  const ShoppingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomePageController home = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cart",
          style: GoogleFonts.encodeSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.cart.isEmpty
            ? const Center(
                child: Text("Cart is empty"),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                              height: 20,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                        itemCount: controller.cart.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product =
                              home.detail(controller.cart[index].product_id);
                          Color color = Colors.black;
                          String namecolor = controller.cart[index].color;
                          switch (namecolor) {
                            case "black":
                              color = Colors.black;
                              break;
                            case "brown":
                              color = Colors.brown;
                              break;
                            case "grey":
                              color = Colors.grey;
                              break;
                            // Tambahkan kasus lain sesuai dengan daftar warna yang Anda butuhkan
                            default:
                              color = Colors
                                  .black; // Warna default jika tidak ada yang cocok
                          }
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: controller.cart[index].accept,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      onChanged: (value) {
                                        controller.setAccept(
                                            controller.cart[index].cart_id);
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(product.image)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(product.title,
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14))),
                                          Text(product.category,
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 10))),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              '\$${product.price * controller.cart[index].qty}',
                                              style: GoogleFonts.encodeSans(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14))),
                                          Row(
                                            children: [
                                              Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(),
                                                    color: Colors.white),
                                                child: Center(
                                                  child: Text(controller
                                                      .cart[index].size),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: 22,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(),
                                                    color: color),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          child: const Icon(
                                            IconlyLight.delete,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            Get.snackbar("cart",
                                                "product ${product.title} berhasil dihapus");
                                            controller.delete(
                                                controller.cart[index].cart_id);
                                          }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black),
                                        child: Row(children: [
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.qtyControll(
                                                    "decrement",
                                                    controller
                                                        .cart[index].cart_id);
                                                controller.Price();
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: 25,
                                              child: SizedBox(
                                                child: Center(
                                                  child: Text(
                                                      "${controller.cart[index].qty}",
                                                      style: GoogleFonts.encodeSans(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.qtyControll(
                                                    "increment",
                                                    controller
                                                        .cart[index].cart_id);
                                                controller.Price();
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ]),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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
                            const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text("Checkout | \$${controller.price.value} ",
                                style: GoogleFonts.encodeSans(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    color: Colors.white)),
                          ],
                        ),
                        onTap: () {
                          Get.snackbar("Sorry", "Coming soon");
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
