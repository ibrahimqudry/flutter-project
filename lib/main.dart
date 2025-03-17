import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/bottom_nav_bar.dart';
import 'package:task/review/add_review_screen.dart';
import 'package:task/signin/create_password_screen.dart';
import 'package:task/signin/sign_in_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({this.prefs, super.key});
  final SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'add review': (context) => AddReviewScreen(),
        "forget": (context) => CreatePasswordScreen(),
        "signin": (context) => SignInScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: (prefs != null && prefs!.getString("email") != null && prefs!.getString("email") != 'no')
            ? BottomNavBar(email: prefs!.getString("email")!)
            : SignInScreen(),
      ),
    );
  }
}