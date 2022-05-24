import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hamroh_seller/core/constants.dart';
import 'package:hamroh_seller/core/http_exception.dart';
import 'package:hamroh_seller/models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final Dio dio;
  List<OrderModel> orders = [];

  OrdersProvider({
    required this.dio,
  });

  Future<void> getOrders() async {
    const url = "$baseUrl/orders/seller/";
    try {
      var response = await dio.get(url);
      List<OrderModel> _orders = OrderModel.fromJsonList(response.data);
      orders = _orders;
      notifyListeners();
    } catch (e) {
      print(e);
      throw HttpException(e.toString());
    }
  }
}
