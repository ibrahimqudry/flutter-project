import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/account/details_screen.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/consts/app_function.dart';
import 'package:task/signin/sign_in_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({required this.email, super.key});
  final String email;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool notify = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        spacing: 20,
        children: [
          Image.asset("assets/title.png"),
          Row(
            spacing: 20,
            children: [
              Image.asset("assets/profile.jpg", height: 64, width: 64),
              Text("Ibrahim Qudry", style: TextStyle(fontSize: 20)),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(email: widget.email),
                ),
              );
            },
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.person_2_outlined,
              size: 35,
              color: Colors.grey,
            ),
            title: Text(
              "Account Details",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.credit_card, size: 35, color: Colors.grey),
            title: Text(
              "Current package | Premium",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.message_outlined, size: 35, color: Colors.grey),
            title: Text(
              "Contact Us",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.reviews_outlined, size: 35, color: Colors.grey),
            title: Text(
              "My Review",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.notifications_outlined,
              size: 35,
              color: Colors.grey,
            ),
            title: Text(
              "Notification",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: Switch(
              activeColor: AppColor.primary,
              value: notify,
              onChanged: (value) {
                setState(() {
                  notify = value;
                });
              },
            ),
          ),
          ListTile(
            onTap: () {
              AppFunction.showDialogWidget(
                img: "assets/dialog3.png",
                title: "Thanks for Sharing\n your review!",
                description: "",
                context: context,
                isDone: true,
                isDelete: false,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("email", 'no');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              );
            },
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.logout, size: 35, color: AppColor.primary),
            title: Text(
              "Sign Out",
              style: TextStyle(fontSize: 20, color: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}
