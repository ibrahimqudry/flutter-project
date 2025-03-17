class CompanyModel {
  String? companyImage;
  String? title;
  String? subtitle;

  CompanyModel({ this.companyImage, this.title, this.subtitle});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyImage: json['companyImage'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyImage': companyImage,
      'title': title,
      'subtitle': subtitle,
    };
  }
}
