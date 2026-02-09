import 'package:flutter/material.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<void> _signIn(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final success = await context.read<AuthProvider>().signInWithGoogle();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.of(context).pop(); // Go back to where we came from
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Join the circle.',
              style: AppTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Write, read, and share poetry with the world.',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.secondaryText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
                : ElevatedButton(
                    onPressed: () => _signIn(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryText,
                      side: const BorderSide(color: AppTheme.secondaryText),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder for Google Icon
                        const Icon(Icons.login),
                        const SizedBox(width: 12),
                        Text(
                          'Sign in with Google',
                          style: AppTheme.buttonText.copyWith(color: AppTheme.primaryText),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
