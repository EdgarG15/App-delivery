import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  RestaurantOrdersListPage({Key? key}) : super(key: key);
  RestaurantOrdersListPage con = Get.put(RestaurantOrdersListPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Restaurant"),
      ),
    );
  }
}
