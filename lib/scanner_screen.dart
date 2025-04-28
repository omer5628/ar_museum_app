import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key, required this.onBack});

  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Scanner',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(height: 20),
          const Text(
            'coming soon!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 28),
          ),
          const SizedBox(height: 40),
          ElevatedButton(onPressed: onBack, child: const Text('Back')),
        ],
      ),
    );
  }
}
