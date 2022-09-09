import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';

class UsersProvider extends GetConnect {
  // ignore: prefer_interpolation_to_compose_strings
  String url = Environment.API_URL + 'api/users';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(),
        headers: {'Content-Type': 'application/json'});

    return response;
  }

  Future<ResponseApi> update(User user) async {
    Response response = await put('$url/update', user.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  // Future<Stream> createWithImage(User user, File image) async {
  //   Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createWithImage');
  //   final request = http.MultipartRequest('POST', uri);
  //   request.files.add(http.MultipartFile(
  //       'image', http.ByteStream(image.openRead().cast()), await image.length(),
  //       filename: basename(image.path)));
  //   request.fields['user'] = json.encode(user);
  //   final response = await request.send();
  //   return response.stream.transform(utf8.decoder);
  // }

//? Es utlizando el paquete GET X
  // Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
  //   FormData form = FormData({
  //     'image': MultipartFile(image, filename: basename(image.path)),
  //     'user': json.encode(user)
  //   });
  //   Response response = await post('$url/createWithImage', form);

  //   if (response.body == null) {
  //     Get.snackbar("Error en la petición", "No se pudo crear el usuario");
  //     return ResponseApi();
  //   }
  //   ResponseApi responseApi = ResponseApi.fromJson(response.body);
  //   return responseApi;
  // }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login', {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});

    if (response.body == null) {
      Get.snackbar("Error", "No se pudo ejecutar la petición");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
