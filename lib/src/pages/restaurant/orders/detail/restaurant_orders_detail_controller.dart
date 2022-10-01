import 'package:app_delivery/src/models/order.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/providers/users_provider.dart';
import 'package:get/get.dart';

class RestaurantOrdersDetailController extends GetxController {
  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;
  List<User> users = <User>[].obs;

  UsersProvider usersProvider = UsersProvider();

  RestaurantOrdersDetailController() {
    print('Order: ${order.toJson()}');
    getDeliveryMen();
    getTotal();
  }

  void getDeliveryMen() async {
    var result = await usersProvider.findDeliveryMen();
    users.clear();
    users.addAll(result);
  }

  void getTotal() {
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }
}
