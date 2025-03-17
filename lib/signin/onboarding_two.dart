import 'package:flutter/material.dart';
import 'package:task/signin/custom_widget/onboarding_screen.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      image: "assets/img2.png",
      title: "We'll see you inside",
      text: "Continue",
      onPressed: () {},
    );
  }
}
