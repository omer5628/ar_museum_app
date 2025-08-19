import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:ar_museum_app/providers/font_size_provider.dart';
import 'package:ar_museum_app/app_screen.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // אם תרצה גם הפוך: DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('he'), Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('he'),
      child: ChangeNotifierProvider(
        create: (_) => FontSizeNotifier(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeNotifier>(
      builder: (context, fontSize, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: tr('appTitle'),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder:
              (ctx, child) => MediaQuery(
                data: MediaQuery.of(
                  ctx,
                ).copyWith(textScaleFactor: fontSize.scale),
                child: child!,
              ),
          home: const AppScreen(),
        );
      },
    );
  }
}
