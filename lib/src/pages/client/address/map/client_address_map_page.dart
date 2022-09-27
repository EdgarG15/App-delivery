import 'package:app_delivery/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapPage extends StatelessWidget {
  ClientAddresMapController con = Get.put(ClientAddresMapController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Selecciona la ubicacion',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            _googleMaps(),
            _iconMyLocation(),
            _cardAddress(),
            _buttonAccept(),
          ],
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          'Seleccionar punto',
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(15)),
      ),
    );
  }

  Widget _cardAddress() {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            con.addressName.value,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Center(
      child: Image.asset(
        'assets/img/ubicacion.png',
        height: 45,
        width: 45,
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: con.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        con.initialPosition = position;
      },
      onCameraIdle: () async {
        await con
            .setLocationDraggableInfo(); // obtener latitud y longitud del mapa.
      },
    );
  }
}
