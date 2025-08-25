import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UnknownArtifactPage extends StatelessWidget {
  const UnknownArtifactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "unable_to_identify_h".tr(), // Multilingual text
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "unable_to_identify".tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
