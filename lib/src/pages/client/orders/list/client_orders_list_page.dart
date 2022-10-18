import 'package:app_delivery/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/order.dart';
import '../../../../utils/relative_time_util.dart';

class ClientOrdersListPage extends StatelessWidget {
  ClientOrdersListController con = Get.put(ClientOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.status.length,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: AppBar(
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.amber,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[600],
                    tabs: List<Widget>.generate(con.status.length, (index) {
                      return Tab(
                        child: Text(con.status[index]),
                      );
                    }),
                  ),
                ),
              ),
              body: TabBarView(
                children: con.status.map((String status) {
                  return FutureBuilder(
                      future: con.getOrders(status),
                      builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (_, index) {
                                  return _cardOrder(snapshot.data![index]);
                                });
                          } else {
                            return Center(
                                child: NoDataWidget(text: 'No hay ordenes'));
                          }
                        } else {
                          return Center(
                              child: NoDataWidget(text: 'No hay ordenes'));
                        }
                      });
                }).toList(),
              )),
        ));
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () => con.goToOrderDetail(order),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Card(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Order #${order.id}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.amber),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}')),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Repartidor: ${order.delivery?.name ?? 'No asignado'} ${order.delivery?.lastname ?? ''}'),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Entregar en: ${order.address?.address ?? ''}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
