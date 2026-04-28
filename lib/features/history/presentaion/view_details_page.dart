import 'package:flutter/material.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/models/crop_recommendation.dart';

class ViewDetailsPage extends StatelessWidget {
  final HistoryItem history;

  const ViewDetailsPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final req = history.requestPayload;
    final res = history.responsePayload;
    final crops = res?.cropRecommendations ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Analysis Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🌿 HEADER CARD
          _buildHeaderCard(res),

          const SizedBox(height: 16),

          // 🌱 INPUT SECTION
          _sectionTitle("Soil Input"),

          _buildGrid([
            _miniCard("N", req?.n),
            _miniCard("P", req?.p),
            _miniCard("K", req?.k),
            _miniCard("pH", req?.ph),
            _miniCard("EC", req?.ec),
            _miniCard("OM", req?.om),
          ]),

          const SizedBox(height: 20),

          // 🌾 RESULT SECTION
          _sectionTitle("Result"),

          _buildInfoCard("Soil Level", res?.level),
          _buildInfoCard("Soil Color", res?.color),
          _buildInfoCard("Name EN", res?.nameEn),

          const SizedBox(height: 20),

          // 🌱 CROPS SECTION
          _sectionTitle("Recommended Crops"),

          if (crops.isNotEmpty)
            ...crops.map((c) => _buildCropCard(c))
          else
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text("No crop recommendations available"),
            ),
        ],
      ),
    );
  }

  // 🧠 HEADER
  Widget _buildHeaderCard(res) {
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
          const Text(
            "Soil Analysis",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            res?.level ?? "Unknown Level",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // 🧾 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 📦 GRID INPUT
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

  // 📊 INFO CARD
  Widget _buildInfoCard(String title, String? value) {
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
            value ?? "N/A",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // 🌾 CROPS CARD
  Widget _buildCropCard(CropRecommendations crop) {
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
                  crop.cropEn ?? "Unknown Crop",
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                  "${crop.suitability ?? 0}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "Season: ${crop.seasonEn ?? "N/A"}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 6),

          Text(crop.reasonEn ?? "", style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
