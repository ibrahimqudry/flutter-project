import 'package:flutter/material.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    required this.image,
    required this.title,
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String image;
  final String title;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Image.asset(image),

                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonElevated(text: text, onPressed: onPressed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
