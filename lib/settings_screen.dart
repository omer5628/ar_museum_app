import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:ar_museum_app/providers/font_size_provider.dart';
import 'package:ar_museum_app/settings_title.dart';
import 'package:ar_museum_app/help_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  static const _langMap = {'en': 'English', 'he': 'עברית', 'ru': 'Русский'};

  @override
  Widget build(BuildContext context) {
    final currCode = context.locale.languageCode;
    final currDisplay = _langMap[currCode] ?? 'English';

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
              const Divider(),

              // Language
              SettingsTile(
                trKey: 'language',
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    value: currDisplay,
                    decoration: InputDecoration(
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
                          _langMap.entries.firstWhere((e) => e.value == v).key;
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
                    isDense: true,
                    value: context.read<FontSizeNotifier>().scale == 1.3
                      ? 'Large'
                      : context.read<FontSizeNotifier>().scale == 0.8
                          ? 'Small'
                          : 'Medium',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Small', child: Text('Small')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'Large', child: Text('Large')),
                    ],
                    onChanged: (v) {
                      final provider = context.read<FontSizeNotifier>();
                      if (v == 'Large')
                        provider.setLarge();
                      else if (v == 'Small')
                        provider.setSmall();
                      else
                        provider.setMedium();
                    },
                  ),
                ),
              ),

              // How does it work? popup
              SettingsTile(
                trKey: 'help',
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: OutlinedButton(
                    onPressed:
                        () => showHelpDialog(context), // מפנה לאותו דיאלוג
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      tr('howItWorks'), // התווית – How does it work?
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
