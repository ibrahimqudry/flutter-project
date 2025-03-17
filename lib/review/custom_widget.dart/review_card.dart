import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/consts/app_function.dart';
import 'package:task/firebase/review_service.dart';
import 'package:task/models/review_model.dart';
import 'package:task/review/custom_widget.dart/button_elevated_review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({required this.email, required this.reviewModel,this.onPressed, super.key});
  final ReviewModel reviewModel;
  final String email;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          shape: Border.all(color: Color(0xffF0F7FE)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (reviewModel.time).toString(),
                  style: TextStyle(fontSize: 16),
                ),
                ButtonElevatedReview(
                  onPressed: onPressed,
                  text: "Edit",
                  color: Colors.green,
                ),
                ButtonElevatedReview(
                  onPressed: () {
                    AppFunction.showDialogWidget(
                      img: "assets/dialog1.png",
                      title: "Are you sure to\n Delete your Review?",
                      description: "",
                      context: context,
                      isDone: true,
                      isDelete: true,
                      onPressed: () {
                        ReviewService.deleteReview(email, reviewModel.id!);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  text: "Delete",
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: Colors.white,
          shape: Border.all(color: Color(0xffF0F7FE), width: 2),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF0F7FE),
                    image: DecorationImage(
                      image: FileImage(File(reviewModel.productImage!)),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewModel.companyName!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reviewModel.reviewText!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      IntrinsicWidth(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            spacing: 5,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text(
                                (reviewModel.rating).toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
