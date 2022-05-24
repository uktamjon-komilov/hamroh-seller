import 'package:flutter/material.dart';
import 'package:hamroh_seller/components/disabled_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product-detail";

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batafsil"),
        elevation: 0,
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DisabledTextField(
                label: "Nomi",
                text: "RedMi Poco X3",
              ),
              DisabledTextField(
                label: "Nomi",
                text: "RedMi Poco X3",
              ),
              DisabledTextField(
                label: "Nomi",
                text: "RedMi Poco X3",
              ),
              DisabledTextField(
                label: "Nomi",
                text: "RedMi Poco X3",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
