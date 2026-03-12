# Agent Instructions — Parallel Generation

All agents use `subagent_type: "general-purpose"`.

Every agent prompt must embed:
- Resolved PACKAGE_NAME and VERSION
- Full text of `naming_and_rules.md`, `class_manifest.md`, `design_principles.md`
- Relevant page specs from `pages.md`
- The DART/FLUTTER PITFALLS block (from `dart-pitfalls.md`)
- The agent's specific instructions below

---

## Agent A — Foundation
**Skip if VERSION > 1.**

**Files:**
```
lib/main.dart
lib/app.dart
lib/providers/theme_provider.dart
lib/providers/version_provider.dart
lib/themes/theme_names.dart
lib/themes/app_themes.dart
```

**Instructions:**

Create these foundation Flutter files for package `{PACKAGE_NAME}`. Follow naming_and_rules.md conventions and design_principles.md exactly. Apply all DART/FLUTTER PITFALLS rules.

**lib/main.dart** — Calls `runApp(const App())`.

**lib/app.dart** — `class App extends StatelessWidget`
- `MultiProvider` with:
  1. `ChangeNotifierProvider(create: (_) => ThemeProvider())`
  2. `ChangeNotifierProvider(create: (_) => VersionProvider(total: VersionRegistry.total))`
- `Consumer<ThemeProvider>` (NOT context.watch) wrapping `MaterialApp`
- `MaterialApp(theme: AppThemes.of(themeProvider.currentTheme), home: Consumer<VersionProvider>(builder: (_, vp, __) => VersionRegistry.getScaffold(vp.current)))`
- Add `ZoomPageTransitionsBuilder` to `pageTransitionsTheme`
- Import `version_registry.dart` using the path from class_manifest.md

**lib/providers/theme_provider.dart** — `class ThemeProvider extends ChangeNotifier`
- `ThemeNames _currentTheme = ThemeNames.pureWhite`
- `ThemeNames get currentTheme`
- `void setTheme(ThemeNames t)` → update + `notifyListeners()`

**lib/providers/version_provider.dart** — `class VersionProvider extends ChangeNotifier`
- `VersionProvider({required this.total})`
- `final int total`, `int _current = 1`
- `int get current`
- `void setVersion(int v)` → update + `notifyListeners()`

**lib/themes/theme_names.dart** — `enum ThemeNames` with values from themes.md

**lib/themes/app_themes.dart** — `class AppThemes` with `static ThemeData of(ThemeNames name)` — use the exact `switch` expression and seed colors from themes.md. All `ThemeData` must have `useMaterial3: true`.

---

## Agent B — Screens batch 1

**Files:**
```
lib/versions/vN/screens/splash/splash_page.splash.dart
lib/versions/vN/screens/login/login_page.login.dart
lib/versions/vN/screens/login/login_form_widget.login.dart
lib/versions/vN/screens/home/home_page.home.dart
lib/versions/vN/screens/home/feed_item_widget.home.dart
```

**Instructions:**

Create these screen files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — produce a **visually distinct layout** compared to any previous versions while strictly following design_principles.md.

Use page specs from pages.md for Splash (Page 1), Login (Page 2), and Home (Page 3).
Use class names and import paths **exactly** as listed in class_manifest.md — do not invent paths.
Follow naming_and_rules.md (no context.watch, 8dp grid, no hardcoded colors/sizes).
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Import rule:** Each file only imports what it directly uses. `FeedItemWidget` imports nothing from the navigator or shared widgets — only `package:flutter/material.dart` and any sibling widgets it uses.

---

## Agent C — Screens batch 2

**Files:**
```
lib/versions/vN/screens/profile/profile_page.profile.dart
lib/versions/vN/screens/profile/profile_stats_widget.profile.dart
lib/versions/vN/screens/notifications/notifications_page.notifications.dart
lib/versions/vN/screens/notifications/notification_item_widget.notifications.dart
lib/versions/vN/screens/messages/messages_page.messages.dart
lib/versions/vN/screens/messages/message_item_widget.messages.dart
```

**Instructions:**

Create these screen files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — visually distinct from previous versions.
Use page specs from pages.md for Profile (Page 4), Notifications (Page 5), Messages (Page 6).
Use class_manifest.md for all import paths. Follow naming_and_rules.md and design_principles.md.
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Import rule:** Each file only imports what it directly uses.

---

## Agent D — Screens batch 3

**Files:**
```
lib/versions/vN/screens/explore/explore_page.explore.dart
lib/versions/vN/screens/explore/search_bar_widget.explore.dart
lib/versions/vN/screens/create_post/create_post_page.create_post.dart
lib/versions/vN/screens/create_post/media_picker_widget.create_post.dart
lib/versions/vN/screens/story/story_page.story.dart
lib/versions/vN/screens/story/story_progress_widget.story.dart
lib/versions/vN/screens/settings/settings_page.settings.dart
lib/versions/vN/screens/settings/settings_item_widget.settings.dart
```

**Instructions:**

Create these screen files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — visually distinct from previous versions.
Use page specs from pages.md for Explore (7), Create Post (8), Story (9), Settings (10).
`SettingsPage` must be a `StatefulWidget` (needs `_pushEnabled` and `_emailEnabled` bool state for `SwitchListTile`).
Use class_manifest.md for imports. Follow naming_and_rules.md and design_principles.md.
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Import rule:** Each file only imports what it directly uses.

---

## Agent E — Shared widgets
**Skip if VERSION > 1.**

**Files:**
```
lib/widgets/theme_dropdown.dart
lib/widgets/version_switcher.dart
lib/widgets/adaptive_nav_scaffold.dart
```

**Instructions:**

Create these shared widgets for package `{PACKAGE_NAME}`. No `context.watch` — `Consumer` only.
Apply all DART/FLUTTER PITFALLS rules.

**theme_dropdown.dart** — `class ThemeDropdown extends StatelessWidget`
- `const ThemeDropdown({super.key})`
- `Consumer<ThemeProvider>` wrapping a `DropdownButton<ThemeNames>`
- All 10 `ThemeNames` values as items
- Item labels via `_label(ThemeNames t)` switch expression from themes.md
- `onChanged`: `context.read<ThemeProvider>().setTheme(value!)`
- Style: `icon: const Icon(Icons.palette_outlined)`, `underline: const SizedBox.shrink()`

**version_switcher.dart** — `class VersionSwitcher extends StatelessWidget`
- `const VersionSwitcher({super.key})`
- `Consumer<VersionProvider>`
- If `total == 1`: return `const SizedBox.shrink()`
- Otherwise: `Row` of `FilterChip` widgets (V1…VN)
  - `selected: versionProvider.current == i`
  - `onSelected: (_) => context.read<VersionProvider>().setVersion(i)`

**adaptive_nav_scaffold.dart** — `class AdaptiveNavScaffold extends StatefulWidget`
- `const AdaptiveNavScaffold({super.key, required this.pages, required this.destinations, this.appBarTitle})`
- `final List<Widget> pages`, `final List<NavigationDestination> destinations`, `final Widget? appBarTitle`
- `int _selectedIndex = 0`, `void _onSelect(int i) => setState(() => _selectedIndex = i)`
- `LayoutBuilder` on `constraints.maxWidth`:
  - `< 600`: `Scaffold` + `NavigationBar` (bottom) + `IndexedStack`
  - `600–1199`: `Scaffold` + `Row(NavigationRail + VerticalDivider(width: 1) + Expanded(IndexedStack))`
  - `≥ 1200`: `Scaffold` + `Row(NavigationDrawer + Expanded(IndexedStack))`; NavigationDrawer maps destinations to `NavigationDrawerDestination`
- `AppBar` actions always: `const [ThemeDropdown(), VersionSwitcher()]`

---

## Agent F — Version navigator

**Files:**
```
lib/versions/vN/version_vN_navigator.dart
```

**Instructions:**

Create the version navigator for version `vN` of package `{PACKAGE_NAME}`.
Apply all DART/FLUTTER PITFALLS rules.

**`version_vN_navigator.dart`** — `class VersionVNNavigator extends StatefulWidget`
(e.g. v1 → `VersionV1Navigator`, v2 → `VersionV2Navigator`)

- `const VersionVNNavigator({super.key})`
- `StatefulWidget`, state holds `int _selectedIndex = 0`

**Two callbacks — use both:**
```dart
// Narrow: close drawer then update index
void _onSelectNarrow(int index) {
  if (Navigator.canPop(context)) Navigator.pop(context);
  setState(() => _selectedIndex = index);
}
// Wide: update index only (no drawer to close)
void _onSelectWide(int index) => setState(() => _selectedIndex = index);
```

**`build` method** uses `LayoutBuilder`:
- **Wide (≥ 1200dp):**
  ```dart
  Scaffold(
    appBar: AppBar(title: Text('Design Showcase v{VERSION}'), actions: const [ThemeDropdown(), VersionSwitcher()]),
    body: Row(children: [
      NavigationDrawer(selectedIndex: _selectedIndex, onDestinationSelected: _onSelectWide, children: _destinations),
      Expanded(child: IndexedStack(index: _selectedIndex, children: _pages)),
    ]),
  )
  ```
- **Narrow (< 1200dp):**
  ```dart
  Scaffold(
    appBar: AppBar(title: Text('Design Showcase v{VERSION}'), actions: const [ThemeDropdown(), VersionSwitcher()]),
    drawer: NavigationDrawer(selectedIndex: _selectedIndex, onDestinationSelected: _onSelectNarrow, children: _destinations),
    body: IndexedStack(index: _selectedIndex, children: _pages),
  )
  ```

Use all 10 `NavigationDrawerDestination` items and page instances from the **Navigator** section of pages.md.
Import all 10 page classes using `package:{PACKAGE_NAME}/versions/vN/screens/...` from class_manifest.md.
Import `ThemeDropdown` and `VersionSwitcher` from class_manifest.md.
