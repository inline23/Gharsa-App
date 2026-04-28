import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/history/data/models/history_model.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_cubit.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_state.dart';
import 'package:gharsa_app/features/history/presentaion/view_details_page.dart';
import '../../../core/theme/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HistoryCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          "History",
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

      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryError) {
            return _errorView(state.message);
          }

          if (state is HistorySuccess) {
            final list = state.history;

            if (list.isEmpty) {
              return const Center(child: Text("No history yet 🌱"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HistoryCubit>().refreshHistory();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return _historyCard(list[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // ❌ ERROR UI
  Widget _errorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 40, color: Colors.red),
          const SizedBox(height: 10),
          Text(message),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.read<HistoryCubit>().loadHistory();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  // 🧾 CARD
  Widget _historyCard(HistoryItem item) {
    final res = item.responsePayload;

    final name = res?.nameEn ?? "Unknown";
    final level = res?.level ?? "Unknown";
    final color = _hexToColor(res?.color ?? "#999999");
    final date = _formatDate(item.createdAt ?? "");
    final crops = res?.cropRecommendations ?? [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
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
          // HEADER
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  level.toUpperCase(),
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // DATE
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 6),
              Text(date),
            ],
          ),

          const SizedBox(height: 12),

          // 🌱 CROPS (FIXED - NOT BUTTON LOOK)
          if (crops.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: crops.take(3).map((crop) {
                return _cropBadge(crop.cropEn ?? "");
              }).toList(),
            ),

          const SizedBox(height: 14),

          // VIEW DETAILS
          _viewDetailsButton(item),
        ],
      ),
    );
  }

  // 🌱 FIXED CROP BADGE (NON-CLICKABLE LOOK)
  Widget _cropBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.green,
        ),
      ),
    );
  }

  // 🔥 VIEW DETAILS BUTTON (UNCHANGED - GOOD)
  Widget _viewDetailsButton(HistoryItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ViewDetailsPage(history: item)),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility, size: 18, color: Colors.green),
            SizedBox(width: 6),
            Text(
              "View Details",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔧 HELPERS
  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return "${parsed.day}/${parsed.month}/${parsed.year}";
    } catch (_) {
      return date;
    }
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}