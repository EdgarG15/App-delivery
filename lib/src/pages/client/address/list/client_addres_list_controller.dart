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

  ClientAddresListController() {
    print("Direccion de sesion: ${GetStorage().read('address')}");
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    Address a = Address.fromJson(
        GetStorage().read('address') ?? {}); //Direccion de seleccionada
    int index = address.indexWhere((ad) => ad.id == a.id);
    if (index != -1) {
      // la direccion de sesion coincide con los datos de la lista
      radioValue.value == index;
    }
    return address;
  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('Valor: ${value}');
    GetStorage().write('address', address[value].toJson());
  }

  void goToAddressCreate() {
    Get.toNamed('/client/addres/create');
  }
}
