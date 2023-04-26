// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    this.accessToken,
    this.refreshToken,
    this.statusCode,
    this.message,
  });

  String? accessToken;
  String? refreshToken;
  int? statusCode;
  String? message;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "statusCode": statusCode,
        "message": message,
      };
}
