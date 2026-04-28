import 'package:gharsa_app/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final String email;
  RegisterSuccess(this.email);
}


class ForgotPasswordSuccess extends AuthState {
  final String email;
  ForgotPasswordSuccess(this.email);
}

class VerifyResetOtpSuccess extends AuthState {
  final String email;
  final String otp;
  VerifyResetOtpSuccess(this.email , this.otp);
}

class ResetPasswordSuccess extends AuthState {
  final String email;
  ResetPasswordSuccess(this.email);
}


class OtpVerified extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}