import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: ${email}');
    print('Password: ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print("Response Api: ${responseApi.toJson()}");
      if (responseApi.success == true) {
        GetStorage()
            .write('user', responseApi.data); //Datos del usuario en sesión
        //User user = User.fromJson(responseApi.data);
        User myUser = User.fromJson(GetStorage().read('user') ?? {});
        if (myUser.roles!.length > 1) {
          goToRolesPage();
        } else {
          goToClientPage();
        }
      } else {
        Get.snackbar("Login Fallido", responseApi.message ?? '');
      }
    }
  }

  void goToClientPage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el correo');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El correo no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }

    return true;
  }
}
