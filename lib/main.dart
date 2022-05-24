import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hamroh_seller/core/colors.dart';
import 'package:hamroh_seller/providers/authentication_provider.dart';
import 'package:hamroh_seller/providers/create_order_provider.dart';
import 'package:hamroh_seller/providers/orders_provider.dart';
import 'package:hamroh_seller/providers/products_provider.dart';
import 'package:hamroh_seller/routes.dart';
import 'package:hamroh_seller/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => AuthenticationProvider(dio: dio),
              ),
              ChangeNotifierProvider(
                create: (context) => OrdersProvider(dio: dio),
              ),
              ChangeNotifierProvider(
                create: (context) => CreateOrderProvider(),
              ),
              ChangeNotifierProxyProvider<AuthenticationProvider,
                  ProductsProvider>(
                create: (context) => ProductsProvider(
                  dio: dio,
                  auth: AuthenticationProvider(dio: dio),
                ),
                update: (context, auth, _) =>
                    ProductsProvider(dio: dio, auth: auth),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: kPrimaryColor,
                  secondary: kSecondaryColor,
                ),
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.all(kPrimaryColor),
                ),
              ),
              home: LoginScreen(),
              initialRoute: "/login",
              routes: routes,
            ),
          )),
    );
  }
}
