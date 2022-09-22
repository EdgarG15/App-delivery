import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/product.dart';

class ClientOrdersCreateController extends GetxController {
  List<Product> selectedProducts = [];
  var counter = 0.0.obs;
  Product product = Product();

  ClientOrdersCreateController() {
    print('Productos: ${product.toJson()}');
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_bag');
      } else {
        selectedProducts =
            Product.fromJsonList(GetStorage().read('shopping_bag'));
      }
    }
  }
}
