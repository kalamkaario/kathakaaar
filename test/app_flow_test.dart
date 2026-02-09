import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kathakaar/main.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/repositories/auth_repository.dart';
import 'package:kathakaar/repositories/poem_repository.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App flow test: Splash -> Onboarding -> Home -> Detail', (WidgetTester tester) async {
    // Setup Mocks
    final authRepository = MockAuthRepository();
    final poemRepository = MockPoemRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
          ChangeNotifierProvider(create: (_) => PoemProvider(poemRepository)),
        ],
        child: const KathakaarApp(),
      ),
    );

    // Splash Screen
    expect(find.text('Kathakaar'), findsOneWidget);
    expect(find.text('Where poems breathe.'), findsOneWidget);

    // Wait for Splash animation (2s)
    await tester.pumpAndSettle();

    // Wait for Future.delayed (1s). We pump slightly more to be safe.
    await tester.pump(const Duration(seconds: 2));

    // Wait for Navigation Transition (0.8s)
    await tester.pumpAndSettle();

    // Verify Splash is gone
    expect(find.text('Kathakaar'), findsNothing);

    // Onboarding Screen 1
    expect(find.text('Write. Be read. Be remembered.'), findsOneWidget);

    // Tap Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Onboarding Screen 2
    expect(find.text('Read poems in Hindi, English, Hinglish, and more.'), findsOneWidget);

    // Tap Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Onboarding Screen 3
    expect(find.text('Start your journey.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Get Started
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Home Screen
    // We expect poems to be loaded. MockPoemRepository has a delay.
    // Wait for poem fetch
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify poem content exists
    expect(find.textContaining('Chalti Chakki'), findsOneWidget);

    // Tap on the first poem
    await tester.tap(find.textContaining('Chalti Chakki'));
    await tester.pumpAndSettle();

    // Detail Screen
    // Verify full content is visible (Mock data is short enough to be same text)
    expect(find.textContaining('Diya Kabira Roye'), findsOneWidget);

    // Verify back button works
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Back on Home
    expect(find.textContaining('Chalti Chakki'), findsOneWidget);
  });
}
