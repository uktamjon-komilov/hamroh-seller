import 'package:flutter/material.dart';
import 'package:hamroh_seller/core/colors.dart';
import 'package:hamroh_seller/models/order_model.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: 0),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            order.number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
      title: Text(
        "Buyurtma raqami №${order.number}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        order.orderStatus,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
