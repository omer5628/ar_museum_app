import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// מציג חלון קופץ אחיד עם כל ההסברים
void showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      // כדי להגדיר גודל מרבי ל־Dialog
      final maxHeight = MediaQuery.of(ctx).size.height * 0.8;
      final maxWidth = MediaQuery.of(ctx).size.width * 0.9;

      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // כותרת ראשית
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Text(
                  tr('welcomeTitle'), // "Welcome!"
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              // תוכן שנגלל במידת הצורך
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // פסקת מבוא
                      Text(
                        tr('welcomeMessage'),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // כותרת שנייה
                      Text(
                        tr('howItWorks'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // שלבים
                      Text(
                        "• ${tr('stepOne')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "• ${tr('stepTwo')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "• ${tr('stepThree')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              // כפתור סגירה
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(tr('gotIt')), // "Got it!"
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
