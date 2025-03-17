import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/firebase/account_service.dart';
import 'package:task/models/account_details_model.dart';
import 'package:task/signin/custom_widget/button_elevated.dart';
import 'package:task/signin/custom_widget/text_form_field_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.email, super.key});
  final String email;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  File? pickedImg;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    AccountDetailsModel? details = await AccountService.getAccountDetails(
      widget.email,
    );
    if (details != null) {
      setState(() {
        businessController.text = details.businessName ?? '';
        nameController.text = details.fullName ?? '';
        numberController.text = details.mobileNumber ?? '';
        pickedImg = File(details.image!);
      });
    }
    setState(() => isLoading = false);
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        pickedImg = File(pickedFile.path);
      });
    }
  }

  Future<void> saveAccountDetails() async {
    if (!formKey.currentState!.validate()) return;

    String? imageUrl = pickedImg!.path;

    // TODO: Upload new image to Firebase Storage if pickedImg is not null
    // imageUrl = await uploadImage(pickedImg);

    AccountDetailsModel updatedDetails = AccountDetailsModel(
      image: imageUrl,
      businessName: businessController.text,
      fullName: nameController.text,
      mobileNumber: numberController.text,
    );

    await AccountService.setAccountDetails(widget.email, updatedDetails);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Account details updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Personal Details"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Container(
                  height: height - height * 0.12,
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        pickedImg != null
                                            ? FileImage(pickedImg!)
                                            : null,
                                    child:
                                        pickedImg == null
                                            ? Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.white,
                                            )
                                            : null,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.primary,
                                        ),
                                        onPressed:
                                            () =>
                                                pickImage(ImageSource.gallery),
                                        icon: Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.primary,
                                        ),
                                        onPressed:
                                            () => pickImage(ImageSource.camera),
                                        icon: Icon(
                                          Icons.camera,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'Camera',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            TextFormFieldWidget(
                              controller: businessController,
                              hintText: "Your Business Name",
                            ),
                            TextFormFieldWidget(
                              controller: nameController,
                              hintText: "Your Full Name",
                            ),
                            TextFormFieldWidget(
                              controller: numberController,
                              hintText: "Mobile number",
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20,
                          ),
                          child: ButtonElevated(
                            text: "Save",
                            onPressed: saveAccountDetails,
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
