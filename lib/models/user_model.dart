class UserModel {
  String? email;
  String? password; // Consider encrypting this for security

  UserModel({this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password, // Store as plain text or encrypt before saving
    };
  }
}
