import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/auth/data/repository/auth_repo.dart';
import 'package:gharsa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/history/api/history_service.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_cubit.dart';
import 'package:gharsa_app/features/profile/data/service/profile_service.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_cubit.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/repos/soil_analysis_repo.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/cubit/soil_analysis_cubit.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(AuthRepo(ApiService()))),
        BlocProvider(
          create: (_) => SoilAnalysisCubit(
            repo: SoilAnalysisRepo(apiService: ApiService()),
          ),
        ),
        BlocProvider(create: (_) => HistoryCubit(HistoryService(ApiService()))),
        BlocProvider(create: (_) => ProfileCubit(ProfileService(ApiService()))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gharsa',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
