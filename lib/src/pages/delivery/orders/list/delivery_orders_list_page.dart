import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOrdersListPage extends StatelessWidget {
  DeliveryOrdersListPage({Key? key}) : super(key: key);
  DeliveryOrdersListPage con = Get.put(DeliveryOrdersListPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Delivery"),
      ),
    );
  }
}
