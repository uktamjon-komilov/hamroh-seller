import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int number;
  final String paymentType;
  final String orderStatus;

  OrderModel({
    required this.number,
    required this.paymentType,
    required this.orderStatus,
  });

  static OrderModel fromJson(Map<String, dynamic> data) {
    return OrderModel(
      number: data["number"],
      paymentType: data["payment_type"],
      orderStatus: data["status"],
    );
  }

  static List<OrderModel> fromJsonList(List<dynamic> data) {
    List<OrderModel> _orders = [];
    data.forEach((item) {
      OrderModel _order = OrderModel.fromJson(item);
      _orders.add(_order);
    });
    return _orders;
  }

  @override
  List<Object?> get props => [number];
}
