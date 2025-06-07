import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:ar_museum_app/providers/font_size_provider.dart';
import 'package:ar_museum_app/settings_title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  static const _langMap = {'en': 'English', 'he': 'עברית', 'ru': 'Русский'};

  @override
  Widget build(BuildContext context) {
    final currCode = context.locale.languageCode;
    final currDisplay = _langMap[currCode] ?? 'English';
    final fontProv = context.watch<FontSizeNotifier>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                tr('settings'),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),

              // Language
              SettingsTile(
                trKey: 'language',
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: DropdownButtonFormField<String>(
                    value: currDisplay,
                    isExpanded: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items:
                        _langMap.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      final code =
                          _langMap.entries
                              .firstWhere((entry) => entry.value == v)
                              .key;
                      context.setLocale(Locale(code));
                    },
                  ),
                ),
              ),

              // Text Size
              SettingsTile(
                trKey: 'textSize',
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: DropdownButtonFormField<String>(
                    value: fontProv.scale == 1.3 ? 'Large' : 'Medium',
                    isExpanded: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Medium',
                        child: Text(
                          tr('Medium'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Large',
                        child: Text(
                          tr('Large'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      if (v == 'Large') {
                        context.read<FontSizeNotifier>().setLarge();
                      } else {
                        context.read<FontSizeNotifier>().setMedium();
                      }
                    },
                  ),
                ),
              ),

              // Help
              SettingsTile(
                trKey: 'help',
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: Text(
                      tr('How does it work?'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: onBack,
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
