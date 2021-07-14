// To parse this JSON data, do
//
//     final apiUserModel = apiUserModelFromJson(jsonString);

import 'dart:convert';

ApiUserModel apiUserModelFromJson(String str) =>
    ApiUserModel.fromJson(json.decode(str));

String apiUserModelToJson(ApiUserModel data) => json.encode(data.toJson());

class ApiUserModel {
  ApiUserModel({
    this.data,
  });

  List<Datum> data;

  factory ApiUserModel.fromJson(Map<String, dynamic> json) => ApiUserModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
