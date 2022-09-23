import 'package:app_delivery/src/pages/client/address/list/client_addres_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddresListPage extends StatelessWidget {
  ClientAddresListController con = Get.put(ClientAddresListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Direcciones',
          style: TextStyle(color: Colors.black),
        ),
        actions: [_iconAddresCreate()],
      ),
    );
  }

  Widget _iconAddresCreate() {
    return IconButton(
        onPressed: () => con.goToAddressCreate(),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ));
  }
}
