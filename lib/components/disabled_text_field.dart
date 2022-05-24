import 'package:flutter/material.dart';
import 'package:hamroh_seller/components/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class DisabledTextField extends StatelessWidget {
  final String text;
  final String label;

  const DisabledTextField({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomTextField(
        initialValue: text,
        labelText: label,
        outlined: true,
        disabled: true,
      ),
    );
  }
}
