import 'package:app_delivery/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersDetailPage extends StatelessWidget {
  RestaurantOrdersDetailController con =
      Get.put(RestaurantOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Restaurant detail'),
      ),
    );
  }
}
