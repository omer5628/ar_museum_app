import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ar_museum_app/menu_buttons.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  Future<void> _launchWebsite(BuildContext ctx) async {
    final uri = Uri.parse('https://www.jwmww2.org/');
    if (await canLaunchUrl(uri)) {
      // פותח בדפדפן חיצוני (Chrome וכו’)
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // גיבוי – WebView פנימי (אם אין דפדפן במכשיר)
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'About the Museum',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(height: 20),
          MenuButton(
            label: 'Visit Museum Website',
            icon: Icons.public, // אופציונלי
            onPressed: () => _launchWebsite(context),
          ),
          const SizedBox(height: 40),
          ElevatedButton(onPressed: onBack, child: const Text('Back')),
        ],
      ),
    );
  }
}
