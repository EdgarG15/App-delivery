import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddresMapController extends GetxController {
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(28.6483949, -106.0790341), zoom: 14);

  Completer<GoogleMapController> mapController = Completer();

  void onMapCreate(GoogleMapController controller) {
    mapController.complete(controller);
  }
}
