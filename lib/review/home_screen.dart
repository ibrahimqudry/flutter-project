import 'package:flutter/material.dart';
import 'package:task/consts/app_color.dart';
import 'package:task/firebase/services.dart';
import 'package:task/models/company_model.dart';
import 'package:task/review/custom_widget.dart/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.email,super.key});
  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            "Choose Company",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          StreamBuilder<List<CompanyModel>?>(
            stream: Services.getAllCompanies(),
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
                        child: HomeCard(
                          img: data[index].companyImage!,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              'add review',
                              arguments: {
                                "email": widget.email,
                                "img": data[index].companyImage!,
                                "title":data[index].title
                              },
                            );
                          },
                          subTitle: data[index].subtitle!,
                          title: data[index].title!,
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
