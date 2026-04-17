import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle logo = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
    fontFamily: 'Inter',
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );
  
  static const TextStyle categoryTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Inter',
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Inter',
  );
}
