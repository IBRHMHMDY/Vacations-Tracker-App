import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vacation_tracker/presentation/screens/splash_screen.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/blocs/settings/settings_bloc.dart';
import 'presentation/blocs/leaves/leaves_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const VacationsTrackerApp());
}

class VacationsTrackerApp extends StatelessWidget {
  const VacationsTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<SettingsBloc>(),
        ),
        BlocProvider(create: (_) => di.sl<LeavesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vacation Tracker',
        
        // --- إعدادات اللغة والاتجاه (RTL) ---
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // --- إعدادات الوضع الليلي والنهاري ---
        themeMode: ThemeMode.system, // يعتمد على إعدادات نظام المستخدم
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF008080),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Cairo',
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF008080),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Cairo',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

