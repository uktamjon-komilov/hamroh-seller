import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hamroh_seller/core/constants.dart';
import 'package:hamroh_seller/core/http_exception.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationProvider extends ChangeNotifier {
  final Dio dio;

  String? accessToken;
  String? refreshToken;
  int? userId;
  bool loading = false;

  AuthenticationProvider({
    required this.dio,
  });

  Map<String, dynamic> getAuthHeaders() {
    Map<String, dynamic> _headers = {"Content-type": "application/json"};
    if (accessToken != null) _headers["Authorization"] = "Bearer $accessToken";
    return _headers;
  }

  Future<void> login(String username, String password) async {
    const url = "$baseUrl/auth/login/";
    loading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
        "profile_type": "seller",
      };
      var response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode as int == 200) {
        final data = response.data["data"];
        accessToken = data["access"];
        refreshToken = data["refresh"];
        Map<String, dynamic> payload = Jwt.parseJwt(accessToken.toString());
        userId = payload["user_id"];
        loading = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e);
      loading = false;
      notifyListeners();
      throw HttpException(
          e.response!.data["text"] ?? "Oops... Something went wrong");
    }
  }
}
