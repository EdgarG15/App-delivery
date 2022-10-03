// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:app_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:app_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_animated_bottom_bar.dart';
import '../../restaurant/orders/list/restaurant_orders_list_page.dart';
import 'restaurant_home_controller.dart';

class RestaurantHomePage extends StatelessWidget {
  RestaurantHomeController con = Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
              index: con.indexTab.value,
              children: [
                RestaurantOrdersListPage(),
                RestaurantCategoriesCreateePage(),
                RestaurantProductsCreateePage(),
                ClientProfileInfoPage()
              ],
            )));
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.amber,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.list_alt),
                title: const Text('Pedidos'),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.category),
                title: Text('Categoria'),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.restaurant_menu),
                title: Text('Producto'),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Perfil'),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
          ],
        ));
  }
}
