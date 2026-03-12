# Class & Import Manifest

Replace `PACKAGE_NAME` with the actual Flutter package name (from `pubspec.yaml`'s `name:` field).
Replace `vN` with the current version number (e.g. `v1`, `v2`).

---

## Shared Classes (all versions)

| Class | File (relative to lib/) | Import |
|---|---|---|
| `App` | `app.dart` | `package:PACKAGE_NAME/app.dart` |
| `ThemeNames` | `themes/theme_names.dart` | `package:PACKAGE_NAME/themes/theme_names.dart` |
| `AppThemes` | `themes/app_themes.dart` | `package:PACKAGE_NAME/themes/app_themes.dart` |
| `ThemeProvider` | `providers/theme_provider.dart` | `package:PACKAGE_NAME/providers/theme_provider.dart` |
| `VersionProvider` | `providers/version_provider.dart` | `package:PACKAGE_NAME/providers/version_provider.dart` |
| `ThemeDropdown` | `widgets/theme_dropdown.dart` | `package:PACKAGE_NAME/widgets/theme_dropdown.dart` |
| `VersionSwitcher` | `widgets/version_switcher.dart` | `package:PACKAGE_NAME/widgets/version_switcher.dart` |
| `AdaptiveNavScaffold` | `widgets/adaptive_nav_scaffold.dart` | `package:PACKAGE_NAME/widgets/adaptive_nav_scaffold.dart` |
| `VersionConfig` | `versions/version_registry.dart` | `package:PACKAGE_NAME/versions/version_registry.dart` |
| `VersionRegistry` | `versions/version_registry.dart` | `package:PACKAGE_NAME/versions/version_registry.dart` |

---

## Version-Specific Classes (replace vN)

| Class | File path (under lib/) |
|---|---|
| `VersionVNNavigator` | `versions/vN/version_vN_navigator.dart` |
| `ButtonsPage` | `versions/vN/pages/buttons/buttons_page.buttons.dart` |
| `InputsPage` | `versions/vN/pages/inputs/inputs_page.inputs.dart` |
| `ControlsPage` | `versions/vN/pages/controls/controls_page.controls.dart` |
| `NavigationShowcasePage` | `versions/vN/pages/navigation/navigation_showcase_page.navigation.dart` |
| `StepperShowcasePage` | `versions/vN/pages/stepper/stepper_showcase_page.stepper.dart` |
| `CardsPage` | `versions/vN/pages/cards/cards_page.cards.dart` |
| `FeedbackPage` | `versions/vN/pages/feedback/feedback_page.feedback.dart` |
| `ChipsPage` | `versions/vN/pages/chips/chips_page.chips.dart` |
| `ListsPage` | `versions/vN/pages/lists/lists_page.lists.dart` |
| `MediaPage` | `versions/vN/pages/media/media_page.media.dart` |
| `TypographyPage` | `versions/vN/pages/typography/typography_page.typography.dart` |
| `LayoutPage` | `versions/vN/pages/layout/layout_page.layout.dart` |

---

## Import Pattern for Version-Specific Files

```dart
import 'package:PACKAGE_NAME/versions/vN/pages/buttons/buttons_page.buttons.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/inputs/inputs_page.inputs.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/controls/controls_page.controls.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/navigation/navigation_showcase_page.navigation.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/stepper/stepper_showcase_page.stepper.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/cards/cards_page.cards.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/feedback/feedback_page.feedback.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/chips/chips_page.chips.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/lists/lists_page.lists.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/media/media_page.media.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/typography/typography_page.typography.dart';
import 'package:PACKAGE_NAME/versions/vN/pages/layout/layout_page.layout.dart';
// Navigator:
import 'package:PACKAGE_NAME/versions/vN/version_vN_navigator.dart';
```

---

## version_registry.dart Structure

```dart
import 'package:flutter/widgets.dart';
import 'package:PACKAGE_NAME/versions/v1/version_v1_navigator.dart';
// add more version imports here as versions are created

class VersionConfig {
  final String label;
  final Widget Function() scaffold;
  const VersionConfig({required this.label, required this.scaffold});
}

class VersionRegistry {
  static final Map<int, VersionConfig> versions = {
    1: VersionConfig(label: 'V1', scaffold: () => const VersionV1Navigator()),
    // 2: VersionConfig(label: 'V2', scaffold: () => const VersionV2Navigator()),
  };
  static int get total => versions.length;
  static Widget getScaffold(int v) => versions[v]!.scaffold();
}
```

> Note: `VersionConfig` uses `final` for the map (not `const`) because `Widget Function()` is not a const expression.
