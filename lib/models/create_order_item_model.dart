import 'package:equatable/equatable.dart';
import 'package:hamroh_seller/models/product_model.dart';

class CreateOrderItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  CreateOrderItemModel({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product, quantity];
}
