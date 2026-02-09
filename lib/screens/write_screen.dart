import 'package:flutter/material.dart';
import 'package:kathakaar/models/poem_model.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  String _selectedLanguage = 'Hindi';
  final List<String> _languages = ['Hindi', 'English', 'Hinglish', 'Urdu'];

  @override
  void dispose() {
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _publish() async {
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to publish.')),
      );
      return;
    }

    final content = _contentController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something first.')),
      );
      return;
    }

    final poem = PoemModel(
      id: const Uuid().v4(),
      authorId: user.id,
      authorName: user.displayName ?? 'Anonymous',
      content: content,
      language: _selectedLanguage,
      tags: _tagsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      createdAt: DateTime.now(),
    );

    try {
      await context.read<PoemProvider>().addPoem(poem);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Published successfully!')),
        );
        _contentController.clear();
        _tagsController.clear();

        // Go to Home Tab
        // This is tricky from inside a Tab View.
        // We can just stay here or switch tab via callback.
        // For MVP, staying here with success message is fine.
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to publish.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Write', style: AppTheme.headlineMedium),
        elevation: 0,
        backgroundColor: AppTheme.background,
        actions: [
          TextButton(
            onPressed: _publish,
            child: Text(
              'Publish',
              style: AppTheme.buttonText.copyWith(
                color: AppTheme.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _contentController,
              maxLines: null,
              minLines: 8,
              style: AppTheme.bodyLarge,
              cursorColor: AppTheme.primaryText,
              cursorWidth: 1.0, // Thin pen line
              decoration: InputDecoration(
                hintText: 'Write your poem...',
                hintStyle: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.secondaryText.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text('Language', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _languages.map((lang) {
                final isSelected = _selectedLanguage == lang;
                return ChoiceChip(
                  label: Text(lang),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedLanguage = lang;
                    });
                  },
                  selectedColor: AppTheme.accent.withOpacity(0.1),
                  labelStyle: AppTheme.bodyMedium.copyWith(
                    color: isSelected ? AppTheme.accent : AppTheme.secondaryText,
                  ),
                  backgroundColor: AppTheme.surface,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Tags (comma separated)', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            TextField(
              controller: _tagsController,
              style: AppTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: '#love, #silence, #monsoon',
                hintStyle: AppTheme.bodyMedium.copyWith(color: AppTheme.secondaryText.withOpacity(0.5)),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
