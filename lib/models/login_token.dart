// To parse this JSON data, do
//
//     final loginToken = loginTokenFromJson(jsonString);

import 'dart:convert';

LoginToken loginTokenFromJson(String str) =>
    LoginToken.fromJson(json.decode(str));

String loginTokenToJson(LoginToken data) => json.encode(data.toJson());

class LoginToken {
  LoginToken({
    this.success,
  });

  Success? success;

  factory LoginToken.fromJson(Map<String, dynamic> json) => LoginToken(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success!.toJson(),
      };
}

class Success {
  Success({
    this.token,
  });

  String? token;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
