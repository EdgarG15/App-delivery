// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:app_delivery/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/product.dart';
import '../../../../models/user.dart';
import '../../../../utils/relative_time_util.dart';
import '../../../../widgets/no_data_widget.dart';
import 'delivery_orders_detail_controller.dart';

class DeliveryOrdersDetailPage extends StatelessWidget {
  DeliveryOrdersDetailController con =
      Get.put(DeliveryOrdersDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              _dataDate(),
              _dataClient(),
              _dataAddress(),
              _totalToPay(context),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'Order #${con.order.id}',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: con.order.products!.isNotEmpty
            ? ListView(
                children: con.order.products!.map((Product product) {
                  return _cardProduct(product);
                }).toList(),
              )
            : Center(
                child:
                    NoDataWidget(text: 'No hay ningun producto agregado aun'),
              ),
      ),
    );
  }

  Widget _dataClient() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Cliente y Telefono'),
        subtitle: Text(
            '${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Fecha del pedido'),
        subtitle: Text(
            '${RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)}'),
        trailing: const Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Cantidad ${product.quantity}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOTAL: \$${con.total.value}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              con.order.status == 'DESPACHADO'
                  ? _buttonUpdateOrder()
                  : con.order.status == 'EN CAMINO'
                      ? _buttonGoToOrderMap()
                      : Container(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonUpdateOrder() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () => con.updateOrder(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15), backgroundColor: Colors.red),
        child: const Text(
          'Entregar Orden',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buttonGoToOrderMap() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () => con.goToOrderMap(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15), backgroundColor: Colors.amber),
        child: const Text(
          'Volver al mapa',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 50,
      width: 50,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no_image.jpg') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no_image.jpg'),
        ),
      ),
    );
  }
}
