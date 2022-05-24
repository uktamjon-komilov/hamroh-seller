import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamroh_seller/components/custom_text_field.dart';
import 'package:hamroh_seller/core/colors.dart';
import 'package:hamroh_seller/core/resources.dart';
import 'package:hamroh_seller/core/styles.dart';
import 'package:hamroh_seller/providers/authentication_provider.dart';
import 'package:hamroh_seller/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  String? _error;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  _login(BuildContext context) async {
    setState(() {
      _error = null;
    });
    if (_form.currentState!.validate()) {
      try {
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .login(_usernameController.text, _passwordController.text);
        setState(() {
          _error = null;
        });
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SvgPicture.asset(
                R.loginLeftTop,
                width: 35.w,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      R.loginLogo,
                      width: 50.w,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Sotuv bo'limi",
                      style: TextStyles.headline1(),
                    ),
                    Text(
                      "O'z akkauntingizga kiring",
                      style: TextStyles.secondary1(),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 70.w,
                      child: CustomTextField(
                        controller: _usernameController,
                        hintText: "Loginni kiriting",
                        suffixIcon: Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return "Login kiritilishi shart";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: 70.w,
                      child: CustomTextField(
                        controller: _passwordController,
                        hintText: "Parolni kiriting",
                        obscureText: _showPassword,
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return "Parol kiritilishi shart";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _error != null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          _error.toString(),
                          style: TextStyle(color: kRedColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => _login(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        fixedSize: Size(50.w, 40),
                      ),
                      child: authenticationProvider.loading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                          : Text(
                              "Kirish".toUpperCase(),
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(
                R.loginRightBottom,
                width: 50.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
