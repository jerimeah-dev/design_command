import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_command/providers/theme_provider.dart';
import 'package:design_command/themes/theme_names.dart';

class ThemeDropdown extends StatelessWidget {
  const ThemeDropdown({super.key});

  String _label(ThemeNames t) => switch (t) {
    ThemeNames.pureWhite  => 'Pure White',
    ThemeNames.softWhite  => 'Soft White',
    ThemeNames.coolGray   => 'Cool Gray',
    ThemeNames.warmCream  => 'Warm Cream',
    ThemeNames.slate      => 'Slate',
    ThemeNames.charcoal   => 'Charcoal',
    ThemeNames.pureBlack  => 'Pure Black',
    ThemeNames.warmDark   => 'Warm Dark',
    ThemeNames.paper      => 'Paper',
    ThemeNames.blueprint  => 'Blueprint',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return DropdownButton<ThemeNames>(
          value: themeProvider.currentTheme,
          icon: const Icon(Icons.palette_outlined),
          underline: const SizedBox.shrink(),
          onChanged: (value) {
            if (value != null) {
              context.read<ThemeProvider>().setTheme(value);
            }
          },
          items: ThemeNames.values
              .map((t) => DropdownMenuItem(
                    value: t,
                    child: Text(_label(t)),
                  ))
              .toList(),
        );
      },
    );
  }
}
