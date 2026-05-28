import 'package:flutter/material.dart';
import 'package:gharsa_app/core/theme/app_colors.dart';
import 'package:gharsa_app/features/soil anaylsis/data/models/soil_analysis_model.dart';
import 'package:gharsa_app/features/soil anaylsis/presentation/crop_recommendation_screen.dart';
import 'package:readmore/readmore.dart';

class SoilAnalysisResultScreen extends StatelessWidget {
  const SoilAnalysisResultScreen({super.key, required this.soilAnalysisModel});

  final SoilAnalysisModel soilAnalysisModel;

  @override
  Widget build(BuildContext context) {
    final data = soilAnalysisModel.data;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Soil Analysis Result',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// ================== MAIN CARD ==================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 40.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBrown,
                  borderRadius: BorderRadius.circular(32.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// TITLE
                    const Text(
                      'Soil Classification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ICON
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.eco_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// SOIL NAME
                    Text(
                      data?.nameEn ?? "Unknown Soil",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 36),

                    /// ================== EXPERT REPORT ==================
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Expert Soil Report",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// REPORT TEXT
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: ReadMoreText(
                        data?.expertReportEn?.replaceAll(r'\n', '\n\n') ??
                            'No report available',
                        trimLines: 6,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Read More',
                        trimExpandedText: ' Show Less',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                        moreStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        lessStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ================== CROP RECOMMENDATION BUTTON ==================
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CropRecommendationScreen(
                        cropRecommendations: data?.cropRecommendations ?? [],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Crop Recommendation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              /// ================== EXIT BUTTON ==================
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondaryBrown,
                  side: const BorderSide(
                    color: AppColors.secondaryBrown,
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Exit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
