import 'package:flutter/material.dart';
import 'package:task/firebase/user_service.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';
import 'package:task/signin/custom_widget/text_form_field_widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isValidEmail(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: height - height * 0.1,
          padding: EdgeInsets.only(top: height * 0.15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Create a new\n   password",
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
                      hintText: "New Password",
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
                    TextFormFieldWidget(
                      controller: confirmpasswordcontroller,
                      hintText: "Please, repeat new Password",
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20,
                  ),
                  child: ButtonElevated(
                    text: "Save",
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      if (passwordcontroller.text !=
                          confirmpasswordcontroller.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Passwords do not match!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) =>
                                Center(child: CircularProgressIndicator()),
                      );

                      bool success = await UserService.resetPassword(
                        emailcontroller.text,
                        passwordcontroller.text,
                      );

                      // Close loading indicator
                      Navigator.of(context).pop();

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Password updated successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Navigate to login screen
                        Navigator.of(context).pushReplacementNamed("signin");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Failed to update password. Try again!",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
