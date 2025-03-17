import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:task/bottom_nav_bar.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/consts/app_function.dart';
import 'package:task/firebase/review_service.dart';
import 'package:task/models/review_model.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  ReviewModel reviewModel = ReviewModel();
  final textController = TextEditingController();
  final cameraController = TextEditingController();

  File? pickedImg;
  double rate = 0.0;

  Future<void> pickImageGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      pickedImg = File(pickedFile!.path);
      cameraController.text = pickedFile.path;
    });
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      pickedImg = File(pickedFile!.path);
      cameraController.text = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map addReview = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              spacing: 10,
              children: [
                Text(
                  "Well, How satisfied\n       were you?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Image.asset(addReview["img"]),
                RatingBar(
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star_outlined, color: Colors.amber),
                    half: Icon(Icons.star_half_outlined, color: Colors.amber),
                    empty: Icon(Icons.star_border_outlined, color: Colors.grey),
                  ),
                  onRatingUpdate: (val) {
                    rate = val;
                    setState(() {});
                  },
                  minRating: 0,
                  maxRating: 5,
                  allowHalfRating: true,
                ),
                TextField(
                  controller: textController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Type comment here....",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await pickImageCamera();
                        },
                        icon: Icon(Icons.camera_alt_outlined, size: 30),
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        onTap: () async {
                          await pickImageGallery();
                        },
                        controller: cameraController,
                        decoration: InputDecoration(
                          hintText: "Upload image",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A gift is waiting for you effort!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    Icon(Icons.card_giftcard, color: AppColor.primary),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ButtonElevated(
                    text: "Next",
                    onPressed: () {
                      if (rate == 0.0 &&
                          textController.text.isEmpty &&
                          cameraController.text.isEmpty) {
                        AppFunction.showDialogWidget(
                          img: "assets/dialog1.png",
                          title: "please, rate your \nSatisfaction",
                          description: "We need it to give you a gift!",
                          context: context,
                          isDone: false,
                          isDelete: false,
                        );
                      } else if (cameraController.text.isEmpty) {
                        AppFunction.showDialogWidget(
                          img: "assets/dialog2.png",
                          title: "Please, upload or\nmake a photo of work",
                          description:
                              "If you have a photo, please upload\n it now. And we search you more\n interesting gift! ",
                          context: context,
                          isDone: false,
                          isDelete: false,
                        );
                      } else {
                        AppFunction.showDialogWidget(
                          img: "assets/dialog3.png",
                          title: "Thanks for Sharing\n your review!",
                          description: "",
                          context: context,
                          isDone: true,
                          isDelete: false,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        BottomNavBar(email: addReview["email"]),
                              ),
                            );
                          },
                        );
                        String inputDate = "March 2, 2025 at 1:26:50 PM UTC+2";
                        DateTime parsedDate = DateFormat(
                          "MMMM d, yyyy 'at' h:mm:ss a 'UTC'Z",
                        ).parse(inputDate);
                        String formattedDate = DateFormat(
                          "MMM dd h:mm a",
                        ).format(parsedDate);
                        reviewModel.companyName = addReview["title"];
                        reviewModel.time = formattedDate;
                        reviewModel.companyImage = addReview["img"];
                        reviewModel.productImage = cameraController.text;
                        reviewModel.rating = rate;
                        reviewModel.reviewText = textController.text;
                        ReviewService.addReview(
                          addReview["email"],
                          reviewModel,
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
