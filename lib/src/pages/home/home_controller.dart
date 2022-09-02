import 'package:app_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController() {
    // ignore: avoid_print
    print("Usuario de sesion: ${user.toJson()}");
  }
}
