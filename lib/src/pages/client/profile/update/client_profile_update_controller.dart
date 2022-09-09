import 'dart:convert';

import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:app_delivery/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../models/user.dart';

class ClientProfileUpdateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ClientProfileInfoController clientProfileInfoController = Get.find();

  ClientProfileUpdateController() {
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    if (isValidForm(name, lastname, phone)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');
      User myUser = User(
          id: user.id,
          name: name,
          lastname: lastname,
          phone: phone,
          sessionToken: user.sessionToken);

      ResponseApi responseApi = await usersProvider.update(myUser);
      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        clientProfileInfoController.user.value =
            User.fromJson(responseApi.data);
        Get.snackbar("Exito", "Se pudo actualizar los datos correctamente");
      }

      //Response response = await usersProvider.create(user);

      //print('RESPONSE: ${response.body}');
      progressDialog.close();
      //Get.snackbar('Formulario valido', 'Actualizacion con exito');
    }
  }

  bool isValidForm(
    String name,
    String lastname,
    String phone,
  ) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu numero');
      return false;
    }
    return true;
  }
}
