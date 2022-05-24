import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final String category;
  final int price;
  final int? discount;
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.discount,
    required this.quantity,
  });

  static ProductModel fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data["id"],
      title: data["template"]["title"],
      category: data["template"]["category"]["title"],
      price: data["price"],
      discount: data["discount"],
      quantity: data["quantity"],
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> data) {
    List<ProductModel> _products = [];
    data.forEach((item) {
      ProductModel _product = ProductModel.fromJson(item);
      _products.add(_product);
    });
    return _products;
  }

  @override
  List<Object?> get props => [id];
}
