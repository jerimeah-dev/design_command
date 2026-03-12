import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_command/providers/theme_provider.dart';
import 'package:design_command/providers/version_provider.dart';
import 'package:design_command/themes/app_themes.dart';
import 'package:design_command/versions/version_registry.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => VersionProvider(total: VersionRegistry.total)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final theme = AppThemes.of(themeProvider.currentTheme).copyWith(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: const {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.linux: ZoomPageTransitionsBuilder(),
                TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.windows: ZoomPageTransitionsBuilder(),
                TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
              },
            ),
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: Consumer<VersionProvider>(
              builder: (context, vp, child) => VersionRegistry.getScaffold(vp.current),
            ),
          );
        },
      ),
    );
  }
}
