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
        return PopupMenuButton<ThemeNames>(
          tooltip: 'Switch theme',
          onSelected: (value) => context.read<ThemeProvider>().setTheme(value),
          itemBuilder: (context) => ThemeNames.values
              .map((t) => PopupMenuItem<ThemeNames>(
                    value: t,
                    child: Text(_label(t)),
                  ))
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _label(themeProvider.currentTheme),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.palette_outlined),
              const SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }
}
