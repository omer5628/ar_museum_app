import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class InfoPageScreen extends StatelessWidget {
  const InfoPageScreen({super.key, required this.assetPath});
  final String assetPath;

  Future<String> _loadText() => rootBundle.loadString(assetPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info')),
      body: FutureBuilder(
        future: _loadText(),
        builder: (ctx, snap) {
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              snap.data!,
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
