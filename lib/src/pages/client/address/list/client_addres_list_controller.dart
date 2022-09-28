import 'package:app_delivery/src/models/address.dart';
import 'package:app_delivery/src/providers/address_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/user.dart';

class ClientAddresListController extends GetxController {
  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  var radioValue = 0.obs;

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    return address;
  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('Valor: ${value}');
  }

  void goToAddressCreate() {
    Get.toNamed('/client/addres/create');
  }
}
