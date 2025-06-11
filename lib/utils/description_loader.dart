import 'package:flutter/services.dart';

class DescriptionLoader {
  static Future<String> loadDescription(String artifactName) async {
    const path = 'assets/information_pages/info_en.txt';
    final rawData = await rootBundle.loadString(path);
    final lines = rawData.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty || !line.contains(':')) continue;

      final parts = line.split(':');
      final key = parts[0].trim();
      final value = parts.sublist(1).join(':').trim(); // handles ':' in value

      if (key == artifactName) {
        return value;
      }
    }

    return 'Description not found for $artifactName';
  }
}
