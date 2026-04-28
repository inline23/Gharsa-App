import 'package:gharsa_app/features/auth/data/models/user_model.dart';
import 'package:gharsa_app/features/auth/api/api_service.dart';
class AuthRepo {
  final ApiService apiService;

  AuthRepo(this.apiService);

  Future<UserModel?> login({
    required String email,
    required String password,
  }) {
    return apiService.login(
      email: email,
      password: password,
    );
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }){
    return apiService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  Future<bool> verifyOtp(String email, String otp) {
    
    return apiService.verifyOtp(email : email, otp : otp);
  }

  Future<bool> forgotPassword(String email) {
    return apiService.resetPassword(email: email);
  }

  Future<bool> verifyResetOtp(String email, String otp) {
    return apiService.verifyResetOtp(email: email, otp: otp);
  }

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) {
    return apiService.resetPasswordWithOtp(
      email: email,
      otp: otp,
      password: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  
}