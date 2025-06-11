import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArtifactInfoPage extends StatefulWidget {
  final String artifactName;

  const ArtifactInfoPage({super.key, required this.artifactName});

  @override
  State<ArtifactInfoPage> createState() => _ArtifactInfoPageState();
}

class _ArtifactInfoPageState extends State<ArtifactInfoPage> {
  String description = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadArtifactDescription();
  }

  Future<void> loadArtifactDescription() async {
    print("[DEBUG] Loading artifact description for: ${widget.artifactName}");

    final rawData = await rootBundle.loadString('assets/information_pages/info_en.txt');
    print("[DEBUG] Raw data loaded successfully.");

    final lines = rawData.split('\n');

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      print("[DEBUG] Checking line: $trimmedLine");

      if (trimmedLine.startsWith('${widget.artifactName.trim()}:')) {
        final index = trimmedLine.indexOf(':');
        if (index != -1 && index < trimmedLine.length - 1) {
          final result = trimmedLine.substring(index + 1).trim();
          print("[DEBUG] Match found. Description: $result");

          setState(() {
            description = result;
          });
        }
        return;
      }
    }

    print("[DEBUG] No match found. Showing fallback.");
    setState(() {
      description = 'Description not found.';
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artifactName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
