import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kathakaar/models/poem_model.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/screens/poem_detail_screen.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch poems on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PoemProvider>().fetchPoems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Kathakaar',
          style: AppTheme.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Navigate to profile tab or screen
              // For now, we rely on BottomNav, so maybe this is redundant
              // But per requirements, we add it.
            },
          ),
        ],
        elevation: 0,
        backgroundColor: AppTheme.background,
      ),
      body: Consumer<PoemProvider>(
        builder: (context, poemProvider, child) {
          if (poemProvider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.accent));
          }

          if (poemProvider.poems.isEmpty) {
            return Center(
              child: Text(
                'No poems yet. Be the first to write.',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.secondaryText),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemCount: poemProvider.poems.length,
            separatorBuilder: (context, index) => const Divider(
              height: 48,
              color: Colors.transparent, // White space separator
            ),
            itemBuilder: (context, index) {
              final poem = poemProvider.poems[index];
              return PoemItem(poem: poem);
            },
          );
        },
      ),
    );
  }
}

class PoemItem extends StatelessWidget {
  final PoemModel poem;

  const PoemItem({super.key, required this.poem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PoemDetailScreen(poemId: poem.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            poem.content,
            style: AppTheme.bodyLarge,
            textAlign: TextAlign.start,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '— ${poem.authorName}',
                style: AppTheme.bodyMedium.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppTheme.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ActionButton(
                icon: poem.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                label: '${poem.likes}',
                color: poem.isLikedByMe ? AppTheme.accent : AppTheme.secondaryText,
                onTap: () {
                   // Like logic
                   context.read<PoemProvider>().toggleLike(poem.id, 'current_user_id');
                },
              ),
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: '${poem.commentCount}',
                color: AppTheme.secondaryText,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PoemDetailScreen(poemId: poem.id),
                    ),
                  );
                },
              ),
              const Spacer(),
              Text(
                '🌐 ${poem.language}',
                style: AppTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTheme.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
