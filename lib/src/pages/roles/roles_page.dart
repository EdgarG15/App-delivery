import 'package:app_delivery/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/rol.dart';

class RolesPages extends StatelessWidget {
  RolesController controller = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Seleccionar el rol",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.2),
        child: ListView(
          children: controller.user.roles != null
              ? controller.user.roles!.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        // Container(
        //   height: 100,
        //   child: FadeInImage(
        //     image: NetworkImage(rol.image!),
        //     fit: BoxFit.contain,
        //     fadeInDuration: const Duration(milliseconds: 50),
        //     placeholder: const AssetImage('assets/img/no_image.jpg'),
        //   ),
        // ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            controller.goToPageRol(rol);
          },
          child: Text(
            rol.name ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        )
      ],
    );
  }
}
