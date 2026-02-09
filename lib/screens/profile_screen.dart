import 'package:flutter/material.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/providers/poem_provider.dart';
import 'package:kathakaar/screens/home_screen.dart';
import 'package:kathakaar/screens/login_screen.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    if (authProvider.status != AuthStatus.authenticated || user == null) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: Text('Profile', style: AppTheme.headlineMedium),
          elevation: 0,
          backgroundColor: AppTheme.background,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Join the community to see your profile.',
                style: AppTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text('Sign In / Join'),
              ),
            ],
          ),
        ),
      );
    }

    // Filter poems for this user
    final allPoems = context.watch<PoemProvider>().poems;
    final myPoems = allPoems.where((p) => p.authorId == user.id).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(user.displayName ?? 'Profile', style: AppTheme.headlineMedium),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.accent.withOpacity(0.1),
                    backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                    child: user.photoUrl == null
                        ? Text(
                            user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                            style: AppTheme.headlineMedium.copyWith(color: AppTheme.accent),
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.bio ?? 'A poet at heart.',
                    style: AppTheme.bodyMedium.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatItem(label: 'Followers', count: user.followersCount),
                      const SizedBox(width: 32),
                      _StatItem(label: 'Following', count: user.followingCount),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (user.languages.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: user.languages.map((lang) => Chip(
                        label: Text(lang, style: AppTheme.caption),
                        backgroundColor: AppTheme.surface,
                        side: BorderSide(color: AppTheme.secondaryText.withOpacity(0.2)),
                      )).toList(),
                    ),
                  const SizedBox(height: 32),
                  const Divider(),
                ],
              ),
            ),
          ),
          myPoems.isEmpty
          ? SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'You haven\'t written any poems yet.\nStart writing!',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyMedium.copyWith(color: AppTheme.secondaryText),
                  ),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                   final poem = myPoems[index];
                   return Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                     child: Column(
                       children: [
                         PoemItem(poem: poem),
                         const Divider(height: 48, color: Colors.transparent),
                       ],
                     ),
                   );
                },
                childCount: myPoems.length,
              ),
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: AppTheme.headlineMedium.copyWith(fontSize: 20),
        ),
        Text(
          label,
          style: AppTheme.caption,
        ),
      ],
    );
  }
}
