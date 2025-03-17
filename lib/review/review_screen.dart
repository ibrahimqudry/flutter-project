import 'package:flutter/material.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/firebase/review_service.dart';
import 'package:task/models/review_model.dart';
import 'package:task/review/custom_widget.dart/review_card.dart';
import 'package:task/review/edit_review_screen.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({required this.email, super.key});
  final String email;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Text(
            "My Review History",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          StreamBuilder<List<ReviewModel>?>(
            stream: ReviewService.getUserReviewsStream(widget.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                );
              } else {
                var data = snapshot.data;

                if (data == null || data.isEmpty) {
                  return Expanded(child: Center(child: Text("Empty")));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: ReviewCard(
                          email: widget.email,
                          reviewModel: data[index],
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => EditReviewScreen(
                                      email: widget.email,
                                      reviewModel: data[index],
                                    ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: data.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
