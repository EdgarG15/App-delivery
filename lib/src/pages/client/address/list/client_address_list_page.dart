import 'package:app_delivery/src/models/address.dart';
import 'package:app_delivery/src/pages/client/address/list/client_addres_list_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {
  ClientAddressListController con = Get.put(ClientAddressListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Direcciones',
          style: TextStyle(color: Colors.black),
        ),
        actions: [_iconAddresCreate()],
      ),
      body: GetBuilder<ClientAddressListController>(
        builder: (value) => Stack(
          children: [
            _textSelectAddress(),
            _ListAddress(context),
          ],
        ),
      ),
    );
  }

  Widget _ListAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: FutureBuilder(
          future: con.getAddress(),
          builder: (context, AsyncSnapshot<List<Address>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    itemBuilder: (_, index) {
                      return _radioSelectorAddress(
                          snapshot.data![index], index);
                    });
              } else {
                return Center(
                  child: NoDataWidget(
                    text: 'No hay direcciones',
                  ),
                );
              }
            } else {
              return Center(
                child: NoDataWidget(
                  text: 'No hay direcciones',
                ),
              );
            }
          }),
    );
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: con.radioValue.value,
                onChanged: con.handleRadioValueChange,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? '',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address.colonia ?? '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.createOrder(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            'Continuar',
            style: TextStyle(color: Colors.black),
          )),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30),
      child: const Text(
        'Elige tu direccion',
        style: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
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
