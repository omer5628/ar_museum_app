import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ar_museum_app/info_page_screen.dart'; // ✅ import נכון

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  void _openInfoPage(BuildContext context) {
    final code = context.locale.languageCode;
    final assetPath = 'assets/information_pages/info_$code.txt';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InfoPageScreen(assetPath: assetPath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('scanner'),
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 20),
            Text(
              tr('comingSoon'),
              style: const TextStyle(color: Colors.white70, fontSize: 24),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _openInfoPage(context),
              child: Text(tr('openInfo')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onBack, child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
