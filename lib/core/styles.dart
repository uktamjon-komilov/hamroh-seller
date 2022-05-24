import 'package:flutter/cupertino.dart';
import 'package:hamroh_seller/core/colors.dart';

class TextStyles {
  static TextStyle headline1() {
    return TextStyle(
      fontSize: 24,
      color: kPrimaryColor,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle headline2() {
    return TextStyle(
      fontSize: 20,
      color: kPrimaryColor,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle secondary1() {
    return TextStyle(
      fontSize: 18,
      color: kGreyColor,
      fontWeight: FontWeight.w400,
    );
  }
}
