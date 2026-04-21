import 'package:bloc/bloc.dart';
import 'package:gharsa_app/features/auth/data/models/user_model.dart';
import 'package:gharsa_app/features/auth/data/repository/auth_repo.dart';
import 'package:gharsa_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await repo.login(email: email, password: password);

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());

    try {
      final success = await repo.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (success) {
        emit(RegisterSuccess(email));
      } else {
        emit(AuthError("Registration failed"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
  emit(AuthLoading());

  final success = await repo.verifyOtp(email, otp);

  if (success) {
    emit(OtpVerified());
  } else {
    emit(AuthError("Invalid OTP"));
  }
}
}
