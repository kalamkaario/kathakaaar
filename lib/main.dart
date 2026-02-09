import 'package:flutter/material.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/repositories/auth_repository.dart';
import 'package:kathakaar/repositories/poem_repository.dart';
import 'package:kathakaar/screens/splash_screen.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Repositories (Mock for now)
  final authRepository = MockAuthRepository();
  final poemRepository = MockPoemRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProvider(create: (_) => PoemProvider(poemRepository)),
      ],
      child: const KathakaarApp(),
    ),
  );
}

class KathakaarApp extends StatelessWidget {
  const KathakaarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kathakaar',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
