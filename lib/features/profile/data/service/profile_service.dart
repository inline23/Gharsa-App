import 'dart:convert';
import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/profile/data/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final ApiService apiService;

  ProfileService(this.apiService);

  Future<UserProfileModel> getMe() async {
    final response = await http.get(
      Uri.parse('https://gharsa.semiona.com/api/user/me'),
      headers: await apiService.getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfileModel.fromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<UserProfileModel> updateProfile({
    String? name,
    String? phoneNumber,
    int? cityId,
    String? imagePath,
  }) async {
    final headers = await apiService.getHeaders();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://gharsa.semiona.com/api/user/profile'),
    );

    request.headers.addAll(headers);

    if (name != null && name.trim().isNotEmpty) {
      request.fields['name'] = name;
    }

    if (phoneNumber != null && phoneNumber.trim().isNotEmpty) {
      request.fields['phone_number'] = phoneNumber;
    }

    if (cityId != null) {
      request.fields['city_id'] = cityId.toString();
    }

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('avatar', imagePath));
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Update failed");
  }
}
