import 'package:flutter/material.dart';
import 'package:task/signin/custom_widget/onboarding_screen.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      image: "assets/img1.png",
      title: "Details updated!",
      text: "Sign in",
      onPressed: () {},
    );
  }
}
