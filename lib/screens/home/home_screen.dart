import 'package:flutter/material.dart';
import 'package:hamroh_seller/components/drawer_item.dart';
import 'package:hamroh_seller/core/colors.dart';
import 'package:hamroh_seller/core/resources.dart';
import 'package:hamroh_seller/core/styles.dart';
import 'package:hamroh_seller/screens/orders/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> bodyWidgets = [
    OrdersScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyurtmalar"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: kPrimaryColor),
          child: ListView(
            children: [
              _buildDrawerHeader(),
              DrawerItem(
                text: "Buyurtmalar",
                icon: Icons.person,
                active: index == 0,
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: bodyWidgets[index],
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 150,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.loginLogo,
            width: 200,
          ),
          SizedBox(height: 8),
          Text(
            "Sotuv bo'limi",
            style: TextStyles.headline2(),
          )
        ],
      ),
    );
  }
}
