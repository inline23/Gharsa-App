// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:gharsa_app/features/auth/data/models/user_model.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/soil_analysis_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://gharsa.semiona.com";

  // ================= TOKEN =================
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<String?> printToken() async {
    final token = await getToken();
    return token;
  }

  // ================= LOGIN =================
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        await saveToken(data['data']['token'].toString());
        return UserModel.fromJson(data['data']);
      } else {
        print(data['message']);
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://gharsa.semiona.com/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone_number": phone,
          "password": password,
          "password_confirmation": confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        return true;
      } else {
        print(data['message']);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse('https://gharsa.semiona.com/api/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "otp_code": otp}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print(data['message']);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('https://gharsa.semiona.com/api/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print(data['message']);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://gharsa.semiona.com/api/auth/verify-reset-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "otp_code": otp}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print(data['message']);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://gharsa.semiona.com/api/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "otp_code": otp,
          "password": password,
          "password_confirmation": confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print(data['message']);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  // ================= PREDICT =================
  Future<SoilAnalysisModel?> predict({
    required double ec,
    required double sar,
    required double caco3,
    required double gypsum,
    required double om,
    required double n,
    required double p,
    required double k,
    required double fe,
    required double mn,
    required double zn,
    required double cu,
    required int eDepth,
    required double ph,
    required String texture,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/api/soil/predict?include_expert_report=1'),
        headers: headers,
        body: jsonEncode({
          "ec": ec,
          "sar": sar,
          "caco3": caco3,
          "gypsum": gypsum,
          "om": om,
          "n": n,
          "p": p,
          "k": k,
          "fe": fe,
          "mn": mn,
          "zn": zn,
          "cu": cu,
          "e_depth": eDepth,
          "ph": ph,
          "texture": texture,
        }),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return SoilAnalysisModel.fromJson(json);
      } else if (response.statusCode == 401) {
        print("Unauthorized ❌ → لازم Login تاني");
        return null;
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
