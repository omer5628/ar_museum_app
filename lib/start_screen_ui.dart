import 'package:flutter/material.dart';
import 'package:ar_museum_app/menu_buttons.dart';
import 'package:ar_museum_app/pre_tour_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onSelectScreen});

  final void Function(String) onSelectScreen;
  @override
  Widget build(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // --- רקע הלוגו --- //
        Opacity(
          opacity: 0.15, // שקיפות ‑ שנה כרצונך
          child: Image.asset(
            'assets/images/logo2.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.95, // 80 % מרוחב המסך
          ),
        ),

        // --- תוכן האפליקציה --- //
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Jewish Warrior Museum',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(height: 400),

              // ---- כפתור Scanner ----
              MenuButton(
                label: 'Scanner\t',
                icon: Icons.camera_alt,
                onPressed:
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon…')),
                    ),
              ),
              MenuButton(
                label: 'Pre Tour',
                icon: Icons.play_circle_fill,
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PreTourScreen(
                              onBack:
                                  () =>
                                      Navigator.pop(context), // חזרה למסך-הבית
                            ),
                      ),
                    ),
              ),

              MenuButton(
                label: 'Settings\t',
                icon: Icons.settings,
                onPressed: () => onSelectScreen('settings'),
              ),
              MenuButton(
                label: 'About us\t',
                icon: Icons.question_mark,
                onPressed: () => onSelectScreen('aboutUs'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
