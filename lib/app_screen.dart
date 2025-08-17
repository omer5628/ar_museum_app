import 'package:flutter/material.dart';
import 'package:ar_museum_app/start_screen_ui.dart';
import 'package:ar_museum_app/settings_screen.dart';
import 'package:ar_museum_app/about_us_screen.dart';
import 'package:ar_museum_app/help_dialog.dart';
import 'package:ar_museum_app/scanner_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  String _active = 'home';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showHelpDialog(context);
    });
  }

  void _showIntroDialog() {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('How does it work?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step one: Press the scanner button',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Step two: Take a picture of a representation inside the museum (Note: Only take pictures of physical representations in the museum, not pictures of people or inside the videos)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Step three: Touch the information screen about the exhibit you took',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('Got it!'),
              ),
            ],
          ),
    );
  }

  void _onSelect(String screen) {
    setState(() => _active = screen);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;
    switch (_active) {
      case 'scanner':
        bodyWidget = ScannerScreen(onBack: () => _onSelect('home'));
        break;
      case 'settings':
        bodyWidget = SettingsScreen(onBack: () => _onSelect('home'));
        break;
      case 'aboutUs':
        bodyWidget = AboutUsScreen(onBack: () => _onSelect('home'));
        break;
      default:
        bodyWidget = StartScreen(onSelectScreen: _onSelect);
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 38, 2, 102),
                    Color.fromARGB(255, 106, 43, 201),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/logo2.png',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ),
          Positioned.fill(child: SafeArea(child: bodyWidget)),
        ],
      ),
    );
  }
}
