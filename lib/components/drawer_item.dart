import 'package:flutter/material.dart';
import 'package:hamroh_seller/core/colors.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  final bool active;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
        Navigator.of(context).pop();
      },
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: active ? kYellowColor : Colors.white,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: active ? kYellowColor : Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
