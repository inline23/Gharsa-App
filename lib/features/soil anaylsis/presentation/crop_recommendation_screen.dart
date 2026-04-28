import 'package:flutter/material.dart';
import 'package:gharsa_app/core/theme/app_colors.dart';
import 'package:gharsa_app/features/soil anaylsis/data/models/crop_recommendation.dart';

class CropRecommendationScreen extends StatelessWidget {
  const CropRecommendationScreen({
    super.key,
    required this.cropRecommendations,
  });

  final List<CropRecommendations> cropRecommendations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Crop Recommendations',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: cropRecommendations.isEmpty
          ? const Center(
              child: Text(
                "No recommendations available 🌾",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: cropRecommendations.length,
              itemBuilder: (context, index) {
                final rec = cropRecommendations[index];

                return _cropCard(
                  cropName: rec.cropEn ?? "Unknown",
                  season: rec.seasonEn ?? "Unknown",
                  suitability: rec.suitability ?? 0,
                  reason: rec.reasonEn ?? "",
                );
              },
            ),
    );
  }

  Widget _cropCard({
    required String cropName,
    required String season,
    required int suitability,
    required String reason,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= HEADER =================
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  cropName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// suitability %
              Text(
                "$suitability%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// ================= SEASON =================
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 18),
              const SizedBox(width: 6),
              Text("Season: $season"),
            ],
          ),

          const SizedBox(height: 12),

          /// ================= PROGRESS =================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: suitability / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getSuitabilityColor(suitability),
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// ================= REASON =================
          Text(
            reason,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= COLOR LOGIC =================
  Color _getSuitabilityColor(int value) {
    if (value >= 80) return Colors.green;
    if (value >= 50) return Colors.orange;
    return Colors.red;
  }
}