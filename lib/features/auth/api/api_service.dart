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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
  }

  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
    };
  }

  // ================= HELPERS =================

  Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  Future<http.Response> _postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    bool useToken = false,
  }) async {
    final headers = useToken
        ? await getHeaders()
        : {
            'Content-Type': 'application/json',
          };

    return await http.post(
      _buildUri(endpoint),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  bool _isSuccess(
    http.Response response,
    dynamic data,
  ) {
    return (response.statusCode == 200 ||
            response.statusCode == 201) &&
        data['success'] == true;
  }

  void _printError(dynamic error) {
    print("Error: $error");
  }

  // ================= LOGIN =================

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/login',
        body: {
          "email": email,
          "password": password,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        await saveToken(
          data['data']['token'].toString(),
        );

        return UserModel.fromJson(
          data['data'],
        );
      } else {
        print(data['message']);

        return null;
      }
    } catch (e) {
      _printError(e);

      return null;
    }
  }

  // ================= REGISTER =================

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/register',
        body: {
          "name": name,
          "email": email,
          "phone_number": phone,
          "password": password,
          "password_confirmation": confirmPassword,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= VERIFY OTP =================

  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/verify-otp',
        body: {
          "email": email,
          "otp_code": otp,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= RESEND OTP =================

  Future<bool> resendOtp(String email) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/resend-otp',
        body: {
          "email": email,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= FORGOT PASSWORD =================

  Future<bool> resetPassword({
    required String email,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/forgot-password',
        body: {
          "email": email,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= VERIFY RESET OTP =================

  Future<bool> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/verify-reset-otp',
        body: {
          "email": email,
          "otp_code": otp,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= RESET PASSWORD WITH OTP =================

  Future<bool> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _postRequest(
        endpoint: '/api/auth/reset-password',
        body: {
          "email": email,
          "otp_code": otp,
          "password": password,
          "password_confirmation": confirmPassword,
        },
      );

      final data = jsonDecode(response.body);

      if (_isSuccess(response, data)) {
        return true;
      } else {
        print(data['message']);

        return false;
      }
    } catch (e) {
      _printError(e);

      return false;
    }
  }

  // ================= SOIL ANALYSIS =================

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
      final response = await _postRequest(
        endpoint: '/api/soil/predict?include_expert_report=1',
        useToken: true,
        body: {
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
        },
      );

      if (response.statusCode == 401) {
        print("Unauthorized");

        return null;
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return SoilAnalysisModel.fromJson(data);
      } else {
        print(response.body);

        return null;
      }
    } catch (e) {
      _printError(e);

      return null;
    }
  }
}