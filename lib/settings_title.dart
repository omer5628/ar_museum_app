import 'package:flutter/material.dart';

/// אריח הגדרות בסיסי – תווית בצד שמאל, ו‑child גמיש בצד ימין
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12), // רווח אנכי
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // תווית
          SizedBox(
            width: 90,                                      // רוחב קבוע
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 16),
          // תוכן (Dropdown / Button / טקסט)
          Expanded(child: child),
        ],
      ),
    );
  }
}
