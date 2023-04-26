// To parse this JSON data, do
//
//     final responseUsuario = responseUsuarioFromJson(jsonString);

import 'dart:convert';

ResponseUsuario responseUsuarioFromJson(String str) =>
    ResponseUsuario.fromJson(json.decode(str));

String responseUsuarioToJson(ResponseUsuario data) =>
    json.encode(data.toJson());

class ResponseUsuario {
  ResponseUsuario({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.creationAt,
    this.updatedAt,
    this.statusCode,
    this.message,
  });

  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  DateTime? creationAt;
  DateTime? updatedAt;
  int? statusCode;
  String? message;

  factory ResponseUsuario.fromJson(Map<String, dynamic> json) =>
      ResponseUsuario(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "statusCode": statusCode,
        "message": message,
      };
}
