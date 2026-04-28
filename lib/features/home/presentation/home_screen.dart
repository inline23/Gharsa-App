import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/core/routes/app_routes.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_cubit.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_state.dart';
import 'package:gharsa_app/features/history/presentaion/view_details_page.dart';
import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gharsa', style: Theme.of(context).textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: double.infinity,
                ),
              ),
            ),

            const SizedBox(height: 50),

            _header(),
            const SizedBox(height: 16),

            _lastAnalysisSection(context),

            const SizedBox(height: 24),

            _category(
              context,
              title: 'Soil Analysis',
              img: Image.asset('assets/images/soil.png', width: 27),
              color: AppColors.secondaryBrown,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.soilAnalysis);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 📌 HEADER (NOW DYNAMIC)
  Widget _header() {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        HistoryItem? item;

        if (state is HistorySuccess && state.history.isNotEmpty) {
          item = state.history.first;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Analysis',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              item != null ? _formatDate(item.createdAt ?? "") : "No data",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }

  // 🌱 LAST ANALYSIS
  Widget _lastAnalysisSection(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        HistoryItem? item;

        if (state is HistorySuccess && state.history.isNotEmpty) {
          item = state.history.first;
        }

        if (item == null) {
          return _emptyCard();
        }

        final res = item.responsePayload;
        final crops = res?.cropRecommendations ?? [];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ), //     -----------------------------------------------
                    child: Icon(weight: 36, Icons.baby_changing_station),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          res?.nameEn ?? "Soil Analysis",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          res?.level ?? "Unknown",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (crops.isNotEmpty)
                Wrap(
                  spacing: 6,
                  children: crops.take(2).map((c) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        c.cropEn ?? "",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewDetailsPage(history: item!),
                      ),
                    );
                  },
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ❌ EMPTY STATE
  Widget _emptyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text("No analysis yet 🌱"),
    );
  }

  // 📦 CATEGORY
  Widget _category(
    BuildContext context, {
    required String title,
    required Image img,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: img, // -----------------------------------iamge
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: color),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // 🧠 DATE FORMATTER
  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      final now = DateTime.now();

      if (parsed.day == now.day &&
          parsed.month == now.month &&
          parsed.year == now.year) {
        return "Today";
      }

      return "${parsed.day}/${parsed.month}";
    } catch (_) {
      return date;
    }
  }
}
