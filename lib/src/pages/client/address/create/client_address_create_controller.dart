import 'package:app_delivery/src/pages/client/address/map/client_address_map_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) => ClientAddressMapPage(),
    );

    refPointController.text = refPointMap['address'];
    print('Ref point Map ${refPointMap}');
  }
}
