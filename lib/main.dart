import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/auth/data/repository/auth_repo.dart';
import 'package:gharsa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gharsa_app/features/auth/api/api_service.dart';
import 'package:gharsa_app/features/chatbot/api/chat_bot_api_service.dart';
import 'package:gharsa_app/features/chatbot/presentation/cubit/chat_cubit.dart';
import 'package:gharsa_app/features/cubit/locale_cubit.dart';
import 'package:gharsa_app/features/history/api/history_service.dart';
import 'package:gharsa_app/features/history/presentaion/cubit/history_cubit.dart';
import 'package:gharsa_app/features/profile/data/service/profile_service.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_cubit.dart';
import 'package:gharsa_app/features/soil%20anaylsis/data/repos/soil_analysis_repo.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/cubit/soil_analysis_cubit.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

import 'package:gharsa_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 54, 101, 56),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
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
        BlocProvider(
          create: (_) =>
              ChatCubit(ChatBotApiService(ApiService()))..createSession(),
        ),
      ],
      child: BlocProvider(create: (_) => LocaleCubit(), child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: context.watch<LocaleCubit>().state,

      title: 'Gharsa',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
