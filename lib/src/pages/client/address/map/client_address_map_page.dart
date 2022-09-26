import 'package:app_delivery/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapPage extends StatelessWidget {
  ClientAddresMapController con = Get.put(ClientAddresMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Selecciona la ubicacion',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [_googleMaps()],
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
    );
  }
}
