class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? city;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone_number'],
      city: json['city'],
      token: json['token'],
    );
  }
}