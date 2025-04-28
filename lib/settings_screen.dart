import 'package:flutter/material.dart';
import 'package:ar_museum_app/settings_title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    
    String language = 'English';
    String textSize = 'Medium';
    String themeMode = 'Light';

    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 12),
              const Text('Settings',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Divider(),

              
              SettingsTile(
                label: 'Language',
                child: _buildDropdown<String>(
                  value: language,
                  items: const ['English', 'עברית','Русский'],
                  onChanged: (v) {},
                ),
              ),

              
              SettingsTile(
                label: 'Text Size',
                child: _buildDropdown<String>(
                  value: textSize,
                  items: const ['Small', 'Medium', 'Large'],
                  onChanged: (v) {},
                ),
              ),

              
              SettingsTile(
                label: 'Screen',
                child: _buildDropdown<String>(
                  value: themeMode,
                  items: const ['Light', 'Dark'],
                  onChanged: (v) {},
                ),
              ),

              // --- שורה: Help --- //
              SettingsTile(
                label: 'Help',
                child: OutlinedButton(
                  onPressed: () {}, // TODO: open help dialog
                  child: const Text('Click for help'),
                ),
              ),

              // --- שורה: About us --- //
              SettingsTile(
                label: 'About us',
                child: OutlinedButton(
                  onPressed: () {}, // TODO: navigate to About screen
                  child: const Text('Click for more information\nabout the museum',
                      textAlign: TextAlign.center),
                ),
              ),

              const Spacer(),
              Center(
                child: ElevatedButton(onPressed: onBack, child: const Text('Back')),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Dropdown מוכן לשימוש חוזר
  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(value: e, child: Text(e.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }
}
