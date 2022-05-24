import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hamroh_seller/models/create_order_item_model.dart';

class CreateOrderModel extends Equatable {
  final int number;
  final String paymentType;
  final List<CreateOrderItemModel> items;

  CreateOrderModel({
    required this.number,
    required this.paymentType,
    this.items = const [],
  });

  CreateOrderModel copyWith(
      {int? number, String? paymentType, List<CreateOrderItemModel>? items}) {
    return CreateOrderModel(
      number: number ?? this.number,
      paymentType: paymentType ?? this.paymentType,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [];
}
