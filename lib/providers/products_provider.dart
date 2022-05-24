import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hamroh_seller/core/constants.dart';
import 'package:hamroh_seller/core/http_exception.dart';
import 'package:hamroh_seller/models/product_model.dart';
import 'package:hamroh_seller/providers/authentication_provider.dart';

class ProductsProvider extends ChangeNotifier {
  bool loading = false;
  final Dio dio;
  final AuthenticationProvider auth;
  List<ProductModel> products = [];

  ProductsProvider({
    required this.dio,
    required this.auth,
  });

  Future<void> getProducts({String term = ""}) async {
    loading = true;
    notifyListeners();
    final url = "$baseUrl/warehouse/product/branch/?term=$term";
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: auth.getAuthHeaders(),
        ),
      );
      print(response.data);
      List<ProductModel> _products = [];
      _products = ProductModel.fromJsonList(response.data["data"]);
      products = _products;
      loading = false;
      notifyListeners();
    } on DioError catch (e) {
      loading = false;
      notifyListeners();
      throw HttpException(e.response!.data["text"] ?? e.toString());
    } catch (e) {
      loading = false;
      notifyListeners();
      throw HttpException(e.toString());
    }
  }

  clearProducts() {
    products = [];
    notifyListeners();
  }
}
