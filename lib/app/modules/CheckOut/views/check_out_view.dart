import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/check_out_controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  const CheckOutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckOutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
