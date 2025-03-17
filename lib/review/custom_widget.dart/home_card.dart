import 'package:flutter/material.dart';
import 'package:task/consts/app_color.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.img,
    required this.onTap,
    required this.subTitle,
    required this.title,
    super.key,
  });
  final Function()? onTap;
  final String img;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.all(15),
        leading: Image.asset(img),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 20, color: AppColor.primary),
            ),
          ],
        ),
      ),
    );
  }
}
