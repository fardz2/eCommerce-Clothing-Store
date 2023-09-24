import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/controllers/auth_controller.dart';
import 'package:final_project/app/data/model/Cart.dart';
import 'package:final_project/app/data/model/Product.dart';

import 'package:final_project/app/modules/home/HomePage/controllers/home_page_controller.dart';

import 'package:get/get.dart';

class ShoppingPageController extends GetxController {
  //TODO: Implement ShoppingPageController

  final RxList<Cart> cart = <Cart>[].obs;
  final price = 0.obs;
  final AuthController auth = Get.find();
  @override
  void onInit() {
    super.onInit();

    cartProduct();
  }

  Future<void> addCart(
      String product_id, String size, String color, int qty) async {
    final cart_id =
        "${DateTime.now().toString()}+$product_id+${auth.uid}+$size";
    cart.add(Cart(cart_id, product_id, auth.uid, size, color, qty, true));
    cart.refresh();
    await FirebaseFirestore.instance.collection('cart').add({
      "cart_id": cart_id,
      "product_id": product_id,
      "user_id": auth.uid,
      "size": size,
      "color": color,
      "qty": qty,
      "accept": true
    });
  }

  Future<void> setAccept(String cart_id) async {
    try {
      // Dapatkan dokumen berdasarkan ID
      final edit = cart.firstWhere((items) => items.cart_id == cart_id);
      edit.accept = !edit.accept;
      cart.refresh();
      final result = await FirebaseFirestore.instance
          .collection('cart')
          .where("cart_id", isEqualTo: cart_id)
          .get();
      result.docs.first.reference.update({"accept": edit.accept});
      Price();
    } catch (error) {
      print("Error saat memperbarui dokumen: $error");
    }
  }

  Future<void> delete(String cart_id) async {
    try {
      // Dapatkan koleksi 'product_like' dengan filter berdasarkan field tertentu
      var remove = cart.indexWhere((items) => items.cart_id == cart_id);
      cart.removeAt(remove);
      cart.refresh();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('cart_id', isEqualTo: cart_id)
          .get();

      // Loop melalui dokumen yang sesuai dengan kriteria dan hapus mereka satu per satu
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print("Dokumen berhasil dihapus: ${doc.id}");
      }

      print("Semua dokumen yang sesuai dengan kriteria telah dihapus.");
      Price();
    } catch (error) {
      print("Error saat menghapus dokumen: $error");
    }
  }

  Future<void> qtyControll(String info, String cart_id) async {
    try {
      final qty = cart.firstWhere((items) => items.cart_id == cart_id);
      if (info == "decrement" && qty.qty > 1) {
        qty.qty--;
      } else if (info == "increment") {
        qty.qty++;
      }
      cart.refresh();
      final result = await FirebaseFirestore.instance
          .collection('cart')
          .where("cart_id", isEqualTo: cart_id)
          .get();
      result.docs.first.reference.update({"qty": qty.qty});
      Price();
    } catch (e) {
      print("Error saat mengedit dokumen: $e");
    }
  }

  void Price() {
    int total = 0;
    final HomePageController homeController = Get.find();

    cart.map((element) {
      Product product = homeController.detail(element.product_id);
      if (element.accept && element.product_id == product.product_id) {
        total += product.price * element.qty;
        print(element.accept);
      }
    }).toList();

    print(total);
    price.value = total;
    price.refresh();
  }

  Future<void> cartProduct() async {
    final result = await FirebaseFirestore.instance
        .collection('cart')
        .where("user_id", isEqualTo: auth.uid)
        .get();
    final productList = result.docs.map((doc) {
      return Cart(doc["cart_id"], doc["product_id"], doc['user_id'],
          doc['size'], doc['color'], doc["qty"], doc["accept"]);
    }).toList();
    cart.assignAll(productList);
    Price();
  }
}
