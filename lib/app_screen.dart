import 'package:ar_museum_app/pre_tour_screen.dart';
import 'package:ar_museum_app/scanner_screen.dart';
import 'package:ar_museum_app/start_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:ar_museum_app/settings_screen.dart';
import 'package:ar_museum_app/about_us_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});
  @override
  State<AppScreen> createState() => _AppScreen();
}

class _AppScreen extends State<AppScreen> {
  late Widget activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(onSelectScreen: _switchScreen);
  }

  void _switchScreen(String screenId) {
    setState(() {
      switch (screenId) {
        case 'preTour':
          activeScreen = PreTourScreen(onBack: () => _switchScreen('home'));
          break;
        case 'settings':
          activeScreen = SettingsScreen(onBack: () => _switchScreen('home'));
          break;
        case 'scanner':
          activeScreen = ScannerScreen(onBack: () => _switchScreen('home'));
          break;
        case 'aboutUs':
          activeScreen = AboutUsScreen(onBack: () => _switchScreen('home'));
          break;
        case 'home':
        default:
          activeScreen = StartScreen(onSelectScreen: _switchScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Color(0xFF2B158A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: activeScreen,
      ),
    );
  }
}
