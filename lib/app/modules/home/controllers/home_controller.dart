import 'package:final_project/app/modules/home/FavoritePage/views/favorite_page_view.dart';
import 'package:final_project/app/modules/home/HomePage/views/home_page_view.dart';
import 'package:final_project/app/modules/home/ProfilePage/views/profile_page_view.dart';
import 'package:final_project/app/modules/home/ShoppingPage/views/shopping_page_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final SelectedIndex = 0.obs;
  final List<Widget> widgetOptions = <Widget>[
    const HomePageView(),
    const ShoppingPageView(),
    const FavoritePageView(),
    ProfilePageView(),
  ];
  void setSelectedIndex(int index) {
    SelectedIndex.value = index;
  }
}
