class AccountDetailsModel {
  String? image;
  String? businessName;
  String? fullName;
  String? mobileNumber;

  AccountDetailsModel({
    this.image,
    this.businessName,
    this.fullName,
    this.mobileNumber,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsModel(
      image: json['image'],
      businessName: json['businessName'],
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'businessName': businessName,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
    };
  }
}
