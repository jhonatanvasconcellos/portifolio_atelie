import 'package:atelie_portifolio/core/providers/registration_provider.dart';
import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        registrationProvider.overrideWith((ref) => RegistrationNotifier(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ateliê Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
