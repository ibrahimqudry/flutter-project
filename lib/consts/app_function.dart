import 'package:flutter/material.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';

class AppFunction {
  static Future showDialogWidget({
    String? img,
    String? title,
    String? description,
    BuildContext? context,
    bool? isDone,
    Function()? onPressed,
    bool? isDelete,
    Function()? onPressedCancel,
  }) {
    var width = MediaQuery.of(context!).size.width;

    return showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.white,
            shape: Border(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),

                    Image.asset(img!),
                    Text(
                      textAlign: TextAlign.center,
                      title!,
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    isDone!
                        ? isDelete!
                            ? Column(
                              children: [
                                ButtonElevated(
                                  text: "Yes,sure",
                                  onPressed: onPressed,
                                ),
                                TextButton(
                                  onPressed: onPressedCancel,
                                  child: Text("Cancel Now"),
                                ),
                              ],
                            )
                            : ButtonElevated(
                              text: "Save",
                              onPressed: onPressed,
                            )
                        : Text(
                          textAlign: TextAlign.center,
                          description!,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: AppColor.primary,
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
