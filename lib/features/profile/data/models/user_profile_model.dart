class UserProfileModel {
  final bool? success;
  final String? message;
  final UserData? data;

  UserProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? UserData.fromJson(json['data'])
          : null,
    );
  }
}

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? avatar;
  final bool? isVerified;
  final String? createdAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.city,
    this.avatar,
    this.isVerified,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      city: json['city'],
      avatar: json['avatar'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
    );
  }
}