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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // --- Background logo ---
            Positioned(
              top:
                  constraints.maxHeight *
                  0.15, // slightly lower to leave room for title
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(
                  'assets/images/logo2.png',
                  fit: BoxFit.contain,
                  width: constraints.maxWidth * 0.85,
                ),
              ),
            ),

            // --- Foreground content ---
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                  maxWidth: constraints.maxWidth,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 35), // headline higher

                    Text(
                      tr('appTitle'),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 5), // pushes buttons lower
                    // ---- Scanner ----
                    MenuButton(
                      label: tr('scanner'),
                      icon: Icons.camera_alt,
                      onPressed: () => onSelectScreen('scanner'),
                    ),

                    // ---- Pre Tour ----
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
                    // ---- Settings ----
                    MenuButton(
                      label: tr('settings'),
                      icon: Icons.settings,
                      onPressed: () => onSelectScreen('settings'),
                    ),

                    // ---- About ----
                    MenuButton(
                      label: tr('about'),
                      icon: Icons.info_outline,
                      onPressed: () => onSelectScreen('aboutUs'),
                    ),

                    const Spacer(flex: 1), // bottom space
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
