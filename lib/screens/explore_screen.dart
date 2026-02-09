import 'package:flutter/material.dart';
import 'package:kathakaar/theme/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Explore', style: AppTheme.headlineMedium),
        elevation: 0,
        backgroundColor: AppTheme.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(label: 'Latest', isSelected: true),
                  _FilterChip(label: 'Most Loved', isSelected: false),
                  _FilterChip(label: 'Hindi', isSelected: false),
                  _FilterChip(label: 'English', isSelected: false),
                  _FilterChip(label: 'Urdu', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Dummy list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A hidden gem of a poem found in exploration...',
                        style: AppTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '— Unknown Poet',
                        style: AppTheme.caption,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          label,
          style: AppTheme.caption.copyWith(
            color: isSelected ? Colors.white : AppTheme.primaryText,
          ),
        ),
        backgroundColor: isSelected ? AppTheme.accent : AppTheme.surface,
        side: BorderSide(
          color: isSelected ? Colors.transparent : AppTheme.secondaryText.withOpacity(0.2),
        ),
      ),
    );
  }
}
