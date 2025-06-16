import 'dart:convert';
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
    final languageCode = Localizations.localeOf(context).languageCode;
    final path = 'assets/translations/$languageCode.json';

    try {
      final jsonString = await rootBundle.loadString(path);
      final Map<String, dynamic> data = json.decode(jsonString);

      // Assuming your descriptions are inside an "artifacts" key:
      final Map<String, dynamic>? artifacts = data['artifacts'];
      final desc = artifacts != null && artifacts.containsKey(widget.artifactName)
          ? artifacts[widget.artifactName]
          : 'Description not found.';

      setState(() {
        description = desc;
      });
    } catch (e) {
      setState(() {
        description = 'Failed to load description.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Localizations.localeOf(context).languageCode == 'he';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artifactName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
