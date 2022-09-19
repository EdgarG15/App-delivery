import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_product_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[600],
            tabs: List<Widget>.generate(con.categories.length, (index) {
              return Tab(
                child: Text(con.categories[index].name ?? ''),
              );
            }),
          )),
        ),
        body: Center(
          child: TabBarView(
            children: con.categories.map((Category category) {
              return Container();
            }).toList(),
          ),
        ),
      ),
    );
  }
}
