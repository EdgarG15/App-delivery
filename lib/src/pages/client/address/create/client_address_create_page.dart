import 'package:app_delivery/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddresCreatePage extends StatelessWidget {
  ClientAddressCreateController controller =
      Get.put(ClientAddressCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _textNewAddress(context),
          _iconBack(),
          _boxForm(context),
          Column(),
        ],
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
      height: MediaQuery.of(context).size.height * 0.55,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.28, left: 50, right: 50),
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
            _textFieldAddres(),
            _textFieldColonia(),
            _textFieldReferencia(context),
            const SizedBox(
              height: 10,
            ),
            _buttonCreate(context),
          ],
        ),
      ),
    );
  }

  Widget _iconBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "CREAR",
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textFieldAddres() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.addressController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Direccion', prefixIcon: Icon(Icons.map)),
      ),
    );
  }

  Widget _textNewAddress(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(top: 25),
      alignment: Alignment.center,
      child: Column(
        children: const [
          Icon(
            Icons.map,
            size: 100,
          ),
          Text("Nueva Direccion",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
        ],
      ),
    ));
  }

  Widget _textFieldColonia() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.neighborhoodController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Colonia', prefixIcon: Icon(Icons.location_city)),
      ),
    );
  }

  Widget _textFieldReferencia(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        onTap: () => controller.openGoogleMaps(context),
        controller: controller.addressController,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Punto de referencia',
            prefixIcon: Icon(Icons.location_on)),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
