import 'package:app_delivery/src/models/order.dart';
import 'package:app_delivery/src/providers/orders_provider.dart';
import 'package:get/get.dart';

class RestaurantOrdersListController extends GetxController {
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status =
      <String>['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async {
    return await ordersProvider.findByStatus(status);
  }
}
