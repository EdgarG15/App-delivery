import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String? id;
  String? address;
  String? colonia;
  double? lat;
  double? lng;
  String? idUser;

  Address({
    this.id,
    this.address,
    this.colonia,
    this.lat,
    this.lng,
    this.idUser,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        colonia: json["colonia"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "colonia": colonia,
        "lat": lat,
        "lng": lng,
        "id_user": idUser,
      };
}
