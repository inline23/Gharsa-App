import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gharsa_app/core/widgets/custom_bottom_nav.dart';
import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/chatbot/presentation/chat_screen.dart';
import 'package:gharsa_app/features/chatbot/presentation/cubit/chat_cubit.dart';
import 'package:gharsa_app/features/history/api/history_service.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_cubit.dart';
import 'package:gharsa_app/features/history/presentaion/history_screen.dart';
import 'package:gharsa_app/features/home/presentation/home_screen.dart';
import 'package:gharsa_app/features/profile/presentaion/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  late final HistoryCubit historyCubit;

  @override
  void initState() {
    super.initState();

    historyCubit = HistoryCubit(HistoryService(ApiService()));
  }

  @override
  void dispose() {
    historyCubit.close();
    super.dispose();
  }

  late final screens = [
    const HomeScreen(),

    /// 👇 Cubit is reused properly here
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ChatCubit>(),
                child: const ChatScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
