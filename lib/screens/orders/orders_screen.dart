import 'package:flutter/material.dart';
import 'package:hamroh_seller/components/custom_text_field.dart';
import 'package:hamroh_seller/core/http_exception.dart';
import 'package:hamroh_seller/providers/create_order_provider.dart';
import 'package:hamroh_seller/providers/orders_provider.dart';
import 'package:hamroh_seller/screens/orders/components/order_list_item.dart';
import 'package:hamroh_seller/screens/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isInit = true;
  String? _error;

  TextEditingController _orderNumberController = TextEditingController();
  GlobalKey<FormState> _alertForm = GlobalKey<FormState>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      _isInit = false;
      try {
        await Provider.of<OrdersProvider>(context, listen: false).getOrders();
      } on HttpException catch (e) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);

    return Container(
      width: 100.w,
      height: 100.h,
      child: Stack(
        children: [
          SizedBox(
            height: 100.h - 145,
            child: ListView(
              children: [
                ...ordersProvider.orders
                    .map((order) => OrderListItem(order: order))
                    .toList(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ElevatedButton(
              onPressed: () {
                _showOrderNumberDialog(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: Size(100.w, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text(
                "+ Yangi buyurtma",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showOrderNumberDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: Text("Yangi buyurtma qo'shish"),
                content: Container(
                  height: 80,
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Buyurtma raqamini kiriting"),
                      Form(
                        key: _alertForm,
                        child: CustomTextField(
                          controller: _orderNumberController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return "Buyurtma raqami kiritilishi shart";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _orderNumberController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: Text("Bekor qilish"),
                  ),
                  TextButton(
                    onPressed: _orderNumberController.text.length == 0
                        ? null
                        : () {
                            if (_alertForm.currentState!.validate()) {
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setNumber(
                                      int.parse(_orderNumberController.text));
                              Navigator.of(context)
                                  .pushNamed(ProductsScreen.routeName);
                            }
                          },
                    child: Text("OK"),
                  ),
                ],
                insetPadding: EdgeInsets.zero,
              );
            }),
          );
        });
  }
}
