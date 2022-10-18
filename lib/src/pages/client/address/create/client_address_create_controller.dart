import 'package:app_delivery/src/models/address.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/pages/client/address/list/client_addres_list_controller.dart';
import 'package:app_delivery/src/pages/client/address/map/client_address_map_page.dart';
import 'package:app_delivery/src/providers/address_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController coloniaController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;

  User user = User.fromJson(GetStorage().read('user') ?? {});

  AddressProvider addressProvider = AddressProvider();

  ClientAddressListController clientAddressListController = Get.find();

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientAddressMapPage(),
        isDismissible: false,
        enableDrag: false);

    if (kDebugMode) {
      print('REF POINT MAP $refPointMap');
    }
    refPointController.text = refPointMap['address'];
    latRefPoint = refPointMap['lat'];
    lngRefPoint = refPointMap['lng'];
  }

  void createAddress() async {
    String addressName = addressController.text;
    String colonia = coloniaController.text;

    if (isValidForm(addressName, colonia)) {
      Address address = Address(
          address: addressName,
          colonia: colonia,
          lat: latRefPoint,
          lng: lngRefPoint,
          idUser: user.id);

      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(
          msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

      if (responseApi.success == true) {
        address.id = responseApi.data;
        GetStorage().write('address', address.toJson());

        clientAddressListController.update();

        Get.back();
      }
    }
  }

  bool isValidForm(String address, String neighborhood) {
    if (address.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre de la direccion');
      return false;
    }
    if (neighborhood.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del barrio');
      return false;
    }
    if (latRefPoint == 0) {
      Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      return false;
    }
    if (lngRefPoint == 0) {
      Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      return false;
    }

    return true;
  }
}
