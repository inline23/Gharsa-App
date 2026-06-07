import 'package:flutter/material.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/crop_recommendation.dart';
import 'package:gharsa_app/l10n/app_localizations.dart';

class ViewDetailsPage extends StatelessWidget {
  final HistoryItem history;

  const ViewDetailsPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final req = history.requestPayload;
    final res = history.responsePayload;
    final crops = res?.cropRecommendations ?? [];
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final expertReport = isArabic
        ? (res?.expertReportAr ?? '')
        : (res?.expertReportEn ?? '');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.soilAnalysisDetails,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          //  HEADER CARD
          _buildHeaderCard(context, res),

          const SizedBox(height: 16),

          //  INPUT SECTION
          _sectionTitle(AppLocalizations.of(context)!.soilInput),

          _buildGrid([
            _miniCard("N", req?.n),
            _miniCard("P", req?.p),
            _miniCard("K", req?.k),
            _miniCard("pH", req?.ph),
            _miniCard("EC", req?.ec),
            _miniCard("OM", req?.om),
          ]),

          const SizedBox(height: 20),

          //  RESULT SECTION
          _sectionTitle(AppLocalizations.of(context)!.result),
          _buildInfoCard(
            context,
            AppLocalizations.of(context)!.soilLevel,
            res?.level,
          ),

          _buildInfoCard(
            context,
            AppLocalizations.of(context)!.soilColor,
            res?.color,
          ),
          _buildInfoCard(
            context,
            AppLocalizations.of(context)!.soilType,
            isArabic ? res?.nameAr : res?.nameEn,
          ),

          const SizedBox(height: 20),
          if (expertReport.isNotEmpty) ...[
            _sectionTitle(AppLocalizations.of(context)!.expertReport),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                expertReport,
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
            ),

            const SizedBox(height: 20),
          ],

          //  CROPS SECTION
          _sectionTitle(AppLocalizations.of(context)!.recommendedCrops),

          if (crops.isNotEmpty)
            ...crops.map((c) => _buildCropCard(context, c))
          else
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(AppLocalizations.of(context)!.noCropRecommendations),
            ),
        ],
      ),
    );
  }

  //  HEADER
  Widget _buildHeaderCard(BuildContext context, dynamic res) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade700],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.eco, color: Colors.white, size: 40),

          const SizedBox(height: 16),

          Text(
            res?.level ?? AppLocalizations.of(context)!.unknownLevel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            AppLocalizations.of(context)!.soilAnalysis,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  //  SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  //  GRID INPUT
  Widget _buildGrid(List<Widget> items) {
    return Wrap(spacing: 10, runSpacing: 10, children: items);
  }

  Widget _miniCard(String title, num? value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(value?.toString() ?? "-"),
        ],
      ),
    );
  }

  //  INFO CARD
  Widget _buildInfoCard(BuildContext context, String title, String? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value ?? AppLocalizations.of(context)!.notAvailable,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //  CROPS CARD
  Widget _buildCropCard(BuildContext context, CropRecommendations crop) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final cropName = isArabic
        ? (crop.cropAr ?? crop.cropEn ?? '')
        : (crop.cropEn ?? crop.cropAr ?? '');

    final season = isArabic
        ? (crop.seasonAr ?? crop.seasonEn ?? '')
        : (crop.seasonEn ?? crop.seasonAr ?? '');

    final reason = isArabic
        ? (crop.reasonAr ?? crop.reasonEn ?? '')
        : (crop.reasonEn ?? crop.reasonAr ?? '');

    final suitability = crop.suitability ?? 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco, color: Colors.green),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  cropName.isEmpty
                      ? AppLocalizations.of(context)!.unknownCrop
                      : cropName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$suitability%",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: suitability / 100,
            minHeight: 8,
            borderRadius: BorderRadius.circular(20),
          ),

          const SizedBox(height: 10),

          const SizedBox(height: 6),

          Text(
            "${AppLocalizations.of(context)!.seasonLabel}: "
            "${season.isEmpty ? AppLocalizations.of(context)!.notAvailable : season}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 6),

          Text(reason, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
