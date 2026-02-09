import 'package:flutter/material.dart';
import 'package:kathakaar/providers/auth_provider.dart';
import 'package:kathakaar/screens/explore_screen.dart';
import 'package:kathakaar/screens/home_screen.dart';
import 'package:kathakaar/screens/profile_screen.dart';
import 'package:kathakaar/screens/write_screen.dart';
import 'package:kathakaar/screens/saved_screen.dart';
import 'package:kathakaar/screens/login_screen.dart';
import 'package:kathakaar/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const WriteScreen(), // This might be pushed instead of tab, but prompt says "Bottom navigation: Home, Explore, Write, Saved, Profile"
    const SavedScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) {
       // Write Tab Check Auth
       final authProvider = context.read<AuthProvider>();
       if (authProvider.status != AuthStatus.authenticated) {
         Navigator.of(context).push(
           MaterialPageRoute(builder: (_) => const LoginScreen()),
         );
         return;
       }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_outlined),
            activeIcon: Icon(Icons.create),
            label: 'Write',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
