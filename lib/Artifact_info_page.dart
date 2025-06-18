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
  String label = 'Loading...';
  String description = 'Loading...';
  bool isError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (description == 'Loading...') {
      _loadContent();
    }
  }

  Future<void> _loadContent() async {
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
      _fail('Failed to load content.');
    }
  }

  Future<void> _parseAndSet(String raw) async {
    final data = json.decode(raw) as Map<String, dynamic>;
    final artifacts = data['artifacts'] as Map<String, dynamic>?;
    final labels = data['labels'] as Map<String, dynamic>?;

    final key = widget.artifactName.trim();

    setState(() {
      description = artifacts?[key] as String? ?? 'Description not found.';
      label = labels?[key] as String? ?? widget.artifactName;
      isError = !(artifacts?.containsKey(key) ?? false);
    });
  }

  void _fail(String msg) {
    setState(() {
      description = msg;
      label = widget.artifactName;
      isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 2,
        title: Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            shadowColor: Colors.deepPurple.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.5,
                  color: isError ? Colors.redAccent : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
