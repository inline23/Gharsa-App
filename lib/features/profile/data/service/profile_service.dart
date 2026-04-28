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
}
