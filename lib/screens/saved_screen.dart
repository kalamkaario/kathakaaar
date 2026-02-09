import 'package:flutter/material.dart';
import 'package:kathakaar/theme/app_theme.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Saved Poems', style: AppTheme.headlineMedium),
        elevation: 0,
        backgroundColor: AppTheme.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline, size: 64, color: AppTheme.secondaryText.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text(
              'Your collection is empty.',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}
