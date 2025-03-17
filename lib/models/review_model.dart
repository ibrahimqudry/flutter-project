class ReviewModel {
  String? id;
  String? companyImage;
  String? companyName; // Added company name field
  String? productImage;
  double? rating;
  String? reviewText;
  String? time; // Added time field

  ReviewModel({
    this.id,
    this.companyImage,
    this.companyName,
    this.productImage,
    this.rating,
    this.reviewText,
    this.time,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      companyImage: json['companyImage'],
      companyName: json['companyName'], // Added company name
      productImage: json['productImage'],
      rating: (json['rating'] as num?)?.toDouble(),
      reviewText: json['reviewText'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyImage': companyImage,
      'companyName': companyName, // Added company name
      'productImage': productImage,
      'rating': rating,
      'reviewText': reviewText,
      'time': time,
    };
  }
}
