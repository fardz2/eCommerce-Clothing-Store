import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/data/model/Product.dart';
import 'package:final_project/app/data/model/ProductLike.dart';
import 'package:final_project/app/modules/home/HomePage/views/all_items_view.dart';
import 'package:final_project/app/modules/home/HomePage/views/dress_items_view.dart';
import 'package:final_project/app/modules/home/HomePage/views/hat_items_view.dart';
import 'package:final_project/app/modules/home/HomePage/views/watch_items_view.dart';
import 'package:final_project/app/modules/home/ShoppingPage/controllers/shopping_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement HomePageController

  late TabController controller;
  final SelectedIndex = 0.obs;
  final AuthController auth = Get.find();
  final List<Widget> widgetOptions = const [
    AllItemsView(),
    DressItemsView(),
    HatItemsView(),
    WatchItemsView(),
  ];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxList<Product> product = <Product>[].obs;
  final RxList<ProductLike> productlike = <ProductLike>[].obs;

  @override
  void onInit() {
    super.onInit();

    products();
    controller = TabController(
      vsync: this,
      length: widgetOptions.length,
    );
    likeproduct();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void setSelectedIndex(int index) {
    SelectedIndex.value = index;
  }

  Product detail(String productid) {
    return product.firstWhere((item) => item.product_id == productid);
  }

  List<Product> dress() {
    return product.where((item) => item.category == "dress").toList();
  }

  List<Product> hat() {
    return product.where((item) => item.category == "hat").toList();
  }

  List<Product> watch() {
    return product.where((item) => item.category == "watch").toList();
  }

  List<Product> getLikedProducts() {
    return product.where((product) => product.isLiked).toList();
  }

  void toggleLike(String product_id) {
    final edit = product.firstWhere((items) => items.product_id == product_id);
    edit.isLiked = !edit.isLiked;
    product.refresh();
  }

  Future<void> products() async {
    final result = await FirebaseFirestore.instance.collection('product').get();
    final productList = result.docs.map((doc) {
      String image = doc['image'];
      String cleanedImageUrl = image.replaceAll("'", '');
      return Product(cleanedImageUrl, doc['title'], doc['price'],
          doc['category'], doc["product_id"], false);
    }).toList();
    product.assignAll(productList);
    Get.put(ShoppingPageController(), permanent: true);
  }

  Future<void> likeproduct() async {
    final result = await FirebaseFirestore.instance
        .collection('product_like')
        .where("user_id", isEqualTo: auth.uid)
        .get();
    result.docs.map((doc) {
      productlike.add(ProductLike(doc["product_id"], doc["user_id"]));
    }).toList();
  }

  Future<void> addlikeproduct(String product_id) async {
    productlike.add(ProductLike(product_id, auth.uid));
    productlike.refresh();
    await FirebaseFirestore.instance
        .collection('product_like')
        .add({"product_id": product_id, "user_id": auth.uid});
  }

  Future<void> deletelikeproduct(String product_id) async {
    try {
      // Dapatkan koleksi 'product_like' dengan filter berdasarkan field tertentu
      productlike.removeWhere((element) =>
          element.product_id == product_id && element.user_id == auth.uid);
      productlike.refresh();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('product_like')
          .where('product_id', isEqualTo: product_id)
          .where('user_id', isEqualTo: auth.uid)
          .get();

      // Loop melalui dokumen yang sesuai dengan kriteria dan hapus mereka satu per satu
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print("Dokumen berhasil dihapus: ${doc.id}");
      }

      print("Semua dokumen yang sesuai dengan kriteria telah dihapus.");
    } catch (error) {
      print("Error saat menghapus dokumen: $error");
    }
  }
}
