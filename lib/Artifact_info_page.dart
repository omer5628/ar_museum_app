import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class ArtifactInfoPage extends StatefulWidget {
  final String artifactName;
  const ArtifactInfoPage({super.key, required this.artifactName});

  @override
  ArtifactInfoPageState createState() => ArtifactInfoPageState();
}

class ArtifactInfoPageState extends State<ArtifactInfoPage> {
  String description = 'Loading...';
  bool isError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (description == 'Loading...') {
      _loadDescription();
    }
  }

  Future<void> _loadDescription() async {
    final code = context.locale.languageCode;
    final path = 'assets/translations/$code.json';

    try {
      final raw = await rootBundle.loadString(path);
      await _parseAndSet(raw);
    } catch (_) {
      if (code != 'en') {
        try {
          final rawEn = await rootBundle.loadString('assets/translations/en.json');
          await _parseAndSet(rawEn);
          return;
        } catch (_) {}
      }
      _fail('Failed to load description.');
    }
  }

  Future<void> _parseAndSet(String raw) async {
    final data = json.decode(raw) as Map<String, dynamic>;
    final artifacts = data['artifacts'] as Map<String, dynamic>?;

    final key = widget.artifactName.trim();
    if (artifacts != null && artifacts.containsKey(key)) {
      setState(() {
        description = artifacts[key] as String;
        isError = false;
      });
    } else {
      _fail('Description not found.');
    }
  }

  void _fail(String msg) {
    setState(() {
      description = msg;
      isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.artifactName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: isError ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
