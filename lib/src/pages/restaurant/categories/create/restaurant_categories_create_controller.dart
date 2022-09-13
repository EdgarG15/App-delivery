import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/providers/categories_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CategoriesProvider categoriesProvider = CategoriesProvider();

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

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}
