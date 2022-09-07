import 'package:app_delivery/src/pages/client/products/list/client_product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductosListPage extends StatelessWidget {
  ClientProductosListPage({Key? key}) : super(key: key);
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Clientes"),
            ElevatedButton(
              onPressed: (() {
                con.signOut();
              }),
              child: const Text("Cerrar Sesión"),
            )
          ],
        ),
      ),
    );
  }
}
