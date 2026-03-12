import 'package:flutter/material.dart';
import 'package:design_command/themes/theme_names.dart';

class AppThemes {
  static ThemeData of(ThemeNames name) => switch (name) {
    ThemeNames.pureWhite => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9E9E9E),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.softWhite => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBCAAA4),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.coolGray => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF78909C),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.warmCream => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA1887F),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.slate => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF546E7A),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.charcoal => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF546E7A),
          brightness: Brightness.dark,
        ),
      ),
    ThemeNames.pureBlack => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9E9E9E),
          brightness: Brightness.dark,
        ),
      ),
    ThemeNames.warmDark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA1887F),
          brightness: Brightness.dark,
        ),
      ),
    ThemeNames.paper => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4C4B0),
          brightness: Brightness.light,
        ),
      ),
    ThemeNames.blueprint => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF607D8B),
          brightness: Brightness.light,
        ),
      ),
  };
}
