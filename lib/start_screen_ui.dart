import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ar_museum_app/menu_buttons.dart';
import 'package:ar_museum_app/pre_tour_screen.dart';
import 'package:ar_museum_app/quiz/quiz_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onSelectScreen});

  final void Function(String) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // --- רקע לוגו שקוף --- //
        Opacity(
          opacity: 0.15,
          child: Image.asset(
            'assets/images/logo2.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),

        // --- תוכן --- //
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 80),
              Text(
                tr('appTitle'), // כותרת מתורגמת
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(height: 400),

              // ---- כפתור Scanner ----
              MenuButton(
                label: tr('scanner'),
                icon: Icons.camera_alt,
                onPressed: () => onSelectScreen('scanner'),
              ),

              // ---- כפתור Pre Tour ----
              MenuButton(
                label: tr('preTour'),
                icon: Icons.play_circle_fill,
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PreTourScreen(
                              onBack: () => Navigator.pop(context),
                            ),
                      ),
                    ),
              ),
              // quiz
              MenuButton(
                label: tr('Quiz'),
                icon: Icons.quiz_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QuizScreen()),
                  );
                },
              ),
              // ---- כפתור Settings ----
              MenuButton(
                label: tr('settings'),
                icon: Icons.settings,
                onPressed: () => onSelectScreen('settings'),
              ),

              // ---- כפתור About ----
              MenuButton(
                label: tr('about'),
                icon: Icons.info_outline,
                onPressed: () => onSelectScreen('aboutUs'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
