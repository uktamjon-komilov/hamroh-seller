import 'package:flutter/material.dart';
import 'package:hamroh_seller/core/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool outlined;
  final bool disabled;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.outlined = false,
    this.disabled = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: disabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontSize: 16,
        color: kSecondaryColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: kPrimaryColor),
        labelText: labelText,
        suffixIcon: suffixIcon,
        suffixIconColor: kSecondaryColor,
        contentPadding: outlined ? EdgeInsets.all(10) : null,
        border: outlined
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
        focusedBorder: outlined
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
        enabledBorder: outlined
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kSecondaryColor,
                ),
              ),
      ),
    );
  }
}
