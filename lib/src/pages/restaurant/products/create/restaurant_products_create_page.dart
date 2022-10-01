import 'dart:io';

import 'package:app_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/category.dart';
import 'restaurant_products_create_controller.dart';

class RestaurantProductsCreateePage extends StatelessWidget {
  RestaurantProductsCreateController controller =
      Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            _backgroundCover(context),
            _textNewProduct(context),
            _boxForm(context),
            Column(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
      alignment: Alignment.topCenter,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldPrice(),
            _textFieldDescription(),
            _dropDownCategories(controller.categories),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) =>
                        _cardImage(context, controller.imageFile1, 1),
                  ),
                  const SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) =>
                        _cardImage(context, controller.imageFile2, 2),
                  ),
                  const SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) =>
                        _cardImage(context, controller.imageFile3, 3),
                  ),
                ],
              ),
            ),
            _buttonCreate(context),
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar categoria',
          style: TextStyle(fontSize: 15),
        ),
        items: _dropDownItems(categories),
        value: controller.idCategory.value == ''
            ? null
            : controller.idCategory.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          controller.idCategory.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        controller.showAlertDialog(context, numberFile);
      },
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.18,
          child: imageFile != null
              ? Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                )
              : Image(
                  image: AssetImage('assets/img/images.png'),
                ),
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      child: ElevatedButton(
          onPressed: () {
            controller.createProduct(context);
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "CREAR",
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.category_rounded)),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: 'Precio', prefixIcon: Icon(Icons.attach_money)),
      ),
    );
  }

  Widget _textNewProduct(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(top: 25),
      alignment: Alignment.center,
      child: Column(
        children: const [
          Text("Nuevo Producto",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
        ],
      ),
    ));
  }

  Widget _textFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Descripcion',
          prefixIcon: Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: const Icon(Icons.description),
          ),
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 30),
      child: const Text(
        "INGRESA ESTA INFORMACIÓN",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
