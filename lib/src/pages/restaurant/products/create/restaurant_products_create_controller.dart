import 'dart:io';

import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantProductsCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var idCategory = ''.obs;
  List<Category> categories = <Category>[].obs;

  RestaurantProductsCreateController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;
    print('name: $name');
    print('description $description');

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(name: name, description: description);
      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Formulario valido', responseApi.message ?? '');
      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Formulario no valido', 'Ingresa todos los datos');
    }
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      } else if (numberFile == 2) {
        imageFile2 = File(image.path);
      } else if (numberFile == 3) {
        imageFile3 = File(image.path);
      }
      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(color: Colors.black),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}
