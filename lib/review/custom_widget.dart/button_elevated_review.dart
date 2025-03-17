import 'package:flutter/material.dart';

class ButtonElevatedReview extends StatelessWidget {
  const ButtonElevatedReview({
    required this.onPressed,
    required this.text,
    required this.color,
    super.key,
  });
  final Function()? onPressed;
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
