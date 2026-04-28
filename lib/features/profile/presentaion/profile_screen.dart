import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_cubit.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_state.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });
  }

  Future<void> _refresh() async {
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          // ================= LOADING =================
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ================= ERROR =================
          if (state is ProfileError) {
            return _errorView(state.message);
          }

          // ================= SUCCESS =================
          if (state is ProfileSuccess) {
            final user = state.user;

            return RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // 👤 AVATAR (better UI)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryGreen,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            (user.avatar != null && user.avatar!.isNotEmpty)
                            ? NetworkImage(user.avatar!)
                            : null,
                        child: (user.avatar == null || user.avatar!.isEmpty)
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      user.name ?? "Unknown User",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      user.email ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 25),

                    _infoCard(Icons.phone, "Phone", user.phoneNumber ?? "N/A"),
                    _infoCard(Icons.location_city, "City", user.city ?? "N/A"),
                    _infoCard(
                      Icons.verified,
                      "Verified",
                      user.isVerified == true ? "Yes" : "No",
                    ),
                    _infoCard(
                      Icons.calendar_today,
                      "Joined",
                      _formatDate(user.createdAt ?? ""),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit Profile"),
                      ),
                    ),
                  ],
                ),
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
              context.read<ProfileCubit>().getProfile();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  // 📦 INFO CARD (clean)
  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGreen),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return "${parsed.day}/${parsed.month}/${parsed.year}";
    } catch (_) {
      return date;
    }
  }
}
