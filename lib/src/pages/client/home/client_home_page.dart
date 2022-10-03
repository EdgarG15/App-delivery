import 'package:app_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_animated_bottom_bar.dart';
import '../../delivery/orders/list/delivery_orders_list_page.dart';
import 'client_home_controller.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(
        () => IndexedStack(
          index: con.indexTab.value,
          children: [
            ClientProductsListPage(),
            DeliveryOrdersListPage(),
            ClientProfileInfoPage()
          ],
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Obx(
      () => CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor: Colors.amber,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        selectedIndex: con.indexTab.value,
        onItemSelected: (index) => con.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Productos'),
              activeColor: Colors.white,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.list),
              title: const Text('Mis pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.black),
        ],
      ),
    );
  }
}
