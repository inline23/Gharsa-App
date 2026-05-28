import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/core/routes/app_routes.dart';
import 'package:gharsa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gharsa_app/features/auth/presentation/cubit/auth_state.dart';

import '../../../core/theme/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  Timer? timer;

  int seconds = 30;

  String getOtp() => controllers.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    seconds = 30;

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var c in controllers) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("OTP verified successfully"),
            ),
          );

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.login,
          );
        }

        if (state is OtpResent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("OTP resent successfully"),
            ),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 120),

                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'We sent you a 6 digit code to ${widget.email}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) {
                        return SizedBox(
                          width: 48,
                          height: 58,
                          child: TextField(
                            controller: controllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryGreen,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }

                              if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final otp = getOtp();

                            if (otp.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please enter complete OTP",
                                  ),
                                ),
                              );

                              return;
                            }

                            context.read<AuthCubit>().verifyOtp(
                                  widget.email,
                                  otp,
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),

                  const SizedBox(height: 28),

                  Center(
                    child: GestureDetector(
                      onTap: seconds > 0
                          ? null
                          : () {
                              startTimer();

                              context.read<AuthCubit>().resendOtp(
                                    widget.email,
                                  );
                            },
                      child: RichText(
                        text: TextSpan(
                          text: 'Haven’t got the email yet? ',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: seconds > 0
                                  ? 'Resend in $seconds s'
                                  : 'Resend email',
                              style: TextStyle(
                                color: seconds > 0
                                    ? Colors.grey
                                    : AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}