import 'package:app_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:app_delivery/src/pages/home/home_page.dart';
import 'package:app_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:app_delivery/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/models/user.dart';
import 'src/pages/login/login_page.dart';
import 'src/pages/register/register_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Delivery App",
      initialRoute: userSession.id != null
          ? userSession.roles!.length > 1
              ? '/roles'
              : '/client/products/list'
          : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPages()),
        GetPage(
            name: '/restaurant/orders/list',
            page: () => RestaurantOrdersListPage()),
        GetPage(
            name: '/delivery/orders/list',
            page: () => DeliveryOrdersListPage()),
        GetPage(
            name: '/client/products/list',
            page: () => ClientProductosListPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.amber,
            onPrimary: Colors.grey,
            secondary: Colors.amberAccent,
            onSecondary: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey),
      ),
      navigatorKey: Get.key,
    );
  }
}
