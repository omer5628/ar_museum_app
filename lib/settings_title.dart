import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // הוספת Import ל-easy_localization

/// אריח הגדרות בסיסי – תווית מתורגמת בצד שמאל, ו‑child גמיש בצד ימין
class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, required this.trKey, required this.child});

  /// מפתח התרגום (למשל 'language', 'textSize' וכו')
  final String trKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // תווית מתורגמת
          SizedBox(
            width: 90,
            child: Text(
              tr(trKey),
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          // התוכן (Dropdown / Button וכו')
          Expanded(child: child),
        ],
      ),
    );
  }
}
