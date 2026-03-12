# Theme Specifications

All 10 themes use `ColorScheme.fromSeed()` with neutral/desaturated seed colors.
Each theme maps to one resolved `ThemeData` with a predetermined brightness.
No `darkTheme`/`themeMode` switching — the showcase controls appearance explicitly.

---

## ThemeNames Enum Values & ThemeData

| Enum value | Display name | Seed color | Brightness |
|---|---|---|---|
| `pureWhite` | Pure White | `Color(0xFF9E9E9E)` | `Brightness.light` |
| `softWhite` | Soft White | `Color(0xFFBCAAA4)` | `Brightness.light` |
| `coolGray` | Cool Gray | `Color(0xFF78909C)` | `Brightness.light` |
| `warmCream` | Warm Cream | `Color(0xFFA1887F)` | `Brightness.light` |
| `slate` | Slate | `Color(0xFF546E7A)` | `Brightness.light` |
| `charcoal` | Charcoal | `Color(0xFF546E7A)` | `Brightness.dark` |
| `pureBlack` | Pure Black | `Color(0xFF9E9E9E)` | `Brightness.dark` |
| `warmDark` | Warm Dark | `Color(0xFFA1887F)` | `Brightness.dark` |
| `paper` | Paper | `Color(0xFFD4C4B0)` | `Brightness.light` |
| `blueprint` | Blueprint | `Color(0xFF607D8B)` | `Brightness.light` |

---

## app_themes.dart Implementation

```dart
import 'package:flutter/material.dart';
import 'package:PACKAGE_NAME/themes/theme_names.dart';

class AppThemes {
  static ThemeData of(ThemeNames name) => switch (name) {
    ThemeNames.pureWhite => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9E9E9E), brightness: Brightness.light)),
    ThemeNames.softWhite => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBCAAA4), brightness: Brightness.light)),
    ThemeNames.coolGray  => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF78909C), brightness: Brightness.light)),
    ThemeNames.warmCream => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFA1887F), brightness: Brightness.light)),
    ThemeNames.slate     => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF546E7A), brightness: Brightness.light)),
    ThemeNames.charcoal  => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF546E7A), brightness: Brightness.dark)),
    ThemeNames.pureBlack => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9E9E9E), brightness: Brightness.dark)),
    ThemeNames.warmDark  => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFA1887F), brightness: Brightness.dark)),
    ThemeNames.paper     => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD4C4B0), brightness: Brightness.light)),
    ThemeNames.blueprint => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF607D8B), brightness: Brightness.light)),
  };
}
```

---

## ThemeDropdown Label Map

Use this switch expression in `ThemeDropdown._label(ThemeNames t)`:

```dart
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
```
