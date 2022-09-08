import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController controller =
      Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          //_imageUser(context),
          _buttomSignOut(),
          Column(),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.50,
      color: Colors.amber,
      alignment: Alignment.topCenter,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.25, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context),
          ],
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: () {
            controller.goToProfileUpdate();
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "Actualizar datos",
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textName() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 1),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("Username"),
        subtitle: Text(
            '${controller.user.name ?? ''} ${controller.user.lastname ?? ''}'),
      ),
    );
  }

  Widget _textEmail() {
    return Container(
      margin: const EdgeInsets.only(top: 1, bottom: 1),
      child: ListTile(
        leading: Icon(Icons.email),
        title: Text("Email"),
        subtitle: Text(controller.user.email ?? ''),
      ),
    );
  }

  Widget _textPhone() {
    return Container(
      margin: const EdgeInsets.only(top: 1, bottom: 1),
      child: ListTile(
        leading: Icon(Icons.phone_android),
        title: Text("Telefono"),
        subtitle: Text(controller.user.phone ?? ''),
      ),
    );
  }

  Widget _buttomSignOut() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () => controller.signOut(),
          icon: const Icon(
            Icons.power_settings_new,
            color: Colors.white,
            size: 30,
          )),
    ));
  }
}
