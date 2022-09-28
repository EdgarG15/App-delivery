import 'package:app_delivery/src/pages/client/address/create/client_address_create_page.dart';
import 'package:app_delivery/src/pages/client/address/list/client_address_list_page.dart';
import 'package:app_delivery/src/pages/client/home/client_home_page.dart';
import 'package:app_delivery/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:app_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:app_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:app_delivery/src/pages/client/profile/update/client_profile_update_page.dart';
import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:app_delivery/src/pages/home/home_page.dart';
import 'package:app_delivery/src/pages/login/login_page.dart';
import 'package:app_delivery/src/pages/register/register_page.dart';
import 'package:app_delivery/src/pages/restaurant/home/restaurant_home_page.dart';
import 'package:app_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:app_delivery/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/models/user.dart';

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
    //print('El token de sesion brou: ${userSession.sessionToken}');
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      title: 'Delivery Udemy',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null
          ? userSession.roles!.length > 1
              ? '/roles'
              : '/client/home'
          : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPages()),
        GetPage(
            name: '/restaurant/orders/list', page: () => RestaurantHomePage()),
        GetPage(name: '/restaurant/home', page: () => RestaurantHomePage()),
        GetPage(
            name: '/delivery/orders/list',
            page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: () => ClientHomePage()),
        GetPage(name: '/client/home', page: () => ClientHomePage()),
        GetPage(
            name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(
            name: '/client/profile/update',
            page: () => ClientProfileUpdatePage()),
        GetPage(
            name: '/client/orders/create',
            page: () => ClientOrdersCreatePage()),
        GetPage(
            name: '/client/address/create',
            page: () => ClientAddressCreatePage()),
        GetPage(
            name: '/client/address/list', page: () => ClientAddressListPage()),
      ],
      theme: ThemeData(
          primaryColor: Colors.amber,
          colorScheme: ColorScheme(
              primary: Colors.amber,
              secondary: Colors.amberAccent,
              brightness: Brightness.light,
              onBackground: Colors.grey,
              onPrimary: Colors.grey,
              surface: Colors.grey,
              onSurface: Colors.grey,
              error: Colors.grey,
              onError: Colors.grey,
              onSecondary: Colors.grey,
              background: Colors.grey)),
      navigatorKey: Get.key,
    );
  }
}
