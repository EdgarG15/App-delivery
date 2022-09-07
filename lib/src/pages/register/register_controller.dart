import 'dart:io';

import 'package:app_delivery/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../models/user.dart';

class registerController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String password = passwordController.text.trim();
    String phone = phoneController.text;
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email: ${email}');
    print('Password: ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos...');
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      Response response = await usersProvider.create(user);

      print('RESPONSE: ${response.body}');
      progressDialog.close();
      Get.snackbar('Formulario valido', 'Registro con exito');
      goToLoginPage();
    }
  }

  bool isValidForm(String email, String name, String lastname, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el correo');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El correo no es valido');
      return false;
    }

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

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes confirmar tu contraseña');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'Las contraseñas no coincideb');
      return false;
    }

    return true;
  }

  void goToLoginPage() {
    Get.toNamed('/');
  }

  // Future selectImage(ImageSource imageSource) async {
  //   XFile? image = await picker.pickImage(source: imageSource);
  //   if (image != null) {
  //     imageFile = File(image.path);
  //     update();
  //   }
  // }

  // void showAlertDialog(BuildContext context) {
  //   Widget galleryButton = ElevatedButton(
  //       onPressed: () {
  //         Get.back();
  //         selectImage(ImageSource.gallery);
  //       },
  //       child: const Text(
  //         "Galeria",
  //         style: TextStyle(color: Colors.black),
  //       ));
  //   Widget camaraButton = ElevatedButton(
  //       onPressed: () {
  //         Get.back();
  //         selectImage(ImageSource.camera);
  //       },
  //       child: const Text(
  //         "Camara",
  //         style: TextStyle(color: Colors.black),
  //       ));
  //   AlertDialog alertDialog = AlertDialog(
  //     title: const Text("Selecciona una Opcion"),
  //     actions: [galleryButton, camaraButton],
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alertDialog;
  //       });
  // }
}
