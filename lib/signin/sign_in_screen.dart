import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/bottom_nav_bar.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/firebase/user_service.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';
import 'package:task/signin/custom_widget/text_form_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isValidEmail(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: height - height * 0.058,
          width: width,
          padding: EdgeInsets.only(top: height * 0.15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),

                    TextFormFieldWidget(
                      controller: emailcontroller,
                      hintText: "Your Email",

                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !isValidEmail(value)) {
                          return "Invaild Email";
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      controller: passwordcontroller,
                      hintText: "Your Password",
                      password: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return "Invalid password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ButtonElevated(
                        text: "Sign in",
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (formKey.currentState!.validate()) {
                            await UserService.login(
                              emailcontroller.text,
                              passwordcontroller.text,
                            ).then((value) {
                              if (value != null) {
                                prefs.setString("email", emailcontroller.text);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => BottomNavBar(
                                          email: emailcontroller.text,
                                        ),
                                  ),
                                );
                              }
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("forget");
                        },
                        child: Text(
                          "you Forgot password?",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
