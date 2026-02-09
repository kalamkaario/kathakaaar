import 'package:flutter/material.dart';
import 'package:kathakaar/models/poem_model.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PoemDetailScreen extends StatelessWidget {
  final String poemId;

  const PoemDetailScreen({super.key, required this.poemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppTheme.primaryText),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
               final poem = context.read<PoemProvider>().poems.firstWhere((p) => p.id == poemId);
               Share.share('${poem.content}\n\n— ${poem.authorName}\n\nRead more on Kathakaar app.');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Toggle save
            },
          ),
        ],
      ),
      body: Consumer<PoemProvider>(
        builder: (context, poemProvider, child) {
          final poemIndex = poemProvider.poems.indexWhere((p) => p.id == poemId);
          if (poemIndex == -1) return const Center(child: Text('Poem not found'));

          final poem = poemProvider.poems[poemIndex];

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Centered
              children: [
                const SizedBox(height: 48),
                Text(
                  poem.content,
                  style: AppTheme.headlineMedium.copyWith(
                    fontSize: 22,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  '— ${poem.authorName}',
                  style: AppTheme.bodyMedium.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        poem.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                        color: poem.isLikedByMe ? AppTheme.accent : AppTheme.secondaryText,
                        size: 32,
                      ),
                      onPressed: () {
                        // Like logic
                        context.read<PoemProvider>().toggleLike(poem.id, 'current_user_id');
                      },
                    ),
                    const SizedBox(width: 8),
                    Text('${poem.likes}', style: AppTheme.bodyMedium),
                    const SizedBox(width: 32),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, size: 32, color: AppTheme.secondaryText),
                      onPressed: () {
                        // Show comments
                      },
                    ),
                    const SizedBox(width: 8),
                    Text('${poem.commentCount}', style: AppTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: poem.tags.map((tag) => Chip(
                    label: Text(tag, style: AppTheme.caption),
                    backgroundColor: AppTheme.surface,
                    side: BorderSide(color: AppTheme.secondaryText.withOpacity(0.2)),
                  )).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
