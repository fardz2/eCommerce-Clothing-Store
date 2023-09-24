import 'package:get/get.dart';

class DetailPageController extends GetxController {
  final count = 1.obs;
  final size = "S".obs;
  final color = "grey".obs;
  @override
  void onInit() {
    super.onInit();
  }

  void increment() => count.value++;
  void decrement() {
    if (count.value != 1) count.value--;
  }

  void setSize(String value) {
    size.value = value;

    size.refresh();
  }

  void setColor(String value) {
    color.value = value;
    color.refresh();
  }
}
