import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/product.dart';
import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_product_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
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
                return FutureBuilder(
                    future: con.getProducts(category.id ?? '1'),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardProduct(snapshot.data![index]);
                            });
                      } else {
                        return Container();
                      }
                    });
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ListTile(
        title: Text(product.name ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(product.description ?? ''),
            SizedBox(
              height: 10,
            ),
            Text(
              product.price.toString(),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        trailing: Container(
          height: 70,
          width: 70,
          child: FadeInImage(
            image: product.image1 != null
                ? NetworkImage(product.image1!)
                : AssetImage('assets/img/no_image.jpg') as ImageProvider,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no_image.jpg'),
          ),
        ),
      ),
    );
  }
}
