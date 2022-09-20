import 'package:app_delivery/src/pages/client/products/detail/client_product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsDetailPage extends StatelessWidget {
  ClientProductDetailController con = Get.put(ClientProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(('producto'))),
    );
  }
}
