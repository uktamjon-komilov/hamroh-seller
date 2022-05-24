import 'package:flutter/material.dart';
import 'package:hamroh_seller/screens/home/home_screen.dart';
import 'package:hamroh_seller/screens/login/login_screen.dart';
import 'package:hamroh_seller/screens/orders/order_items_screen.dart';
import 'package:hamroh_seller/screens/products/product_detail_screen.dart';
import 'package:hamroh_seller/screens/products/products_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  OrderItemsScreen.routeName: (context) => OrderItemsScreen(),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
};
