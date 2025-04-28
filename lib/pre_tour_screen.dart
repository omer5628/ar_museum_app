import 'package:flutter/material.dart';

class PreTourScreen extends StatelessWidget {
  const PreTourScreen({super.key, required this.onBack});

  final VoidCallback onBack; // פונקציה שתחזיר למסך‑הבית

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Pre‑Tour',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(height: 20),
          const Text(
            'Here you can pick a tour, read tips, etc.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 40),
          ElevatedButton(onPressed: onBack, child: const Text('Back')),
        ],
      ),
    );
  }
}
