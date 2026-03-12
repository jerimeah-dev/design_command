# Agent Instructions — Parallel Generation

All agents use `subagent_type: "general-purpose"`.

Every agent prompt must embed:
- Resolved PACKAGE_NAME and VERSION
- Full text of `naming_and_rules.md`, `class_manifest.md`, `design_principles.md`
- Relevant page specs from `pages.md`
- The DART/FLUTTER PITFALLS block (from `dart-pitfalls.md`)
- The agent's specific instructions below

---

## ⚠️ ISOLATION RULE — applies to ALL screen agents (B, C, D, E)

**DO NOT read, glob, or inspect any files inside `lib/versions/` that belong to a previous version.** You must not look at existing page implementations. Create a completely fresh design approach for this version — different layout structure, different spacing rhythm, different component arrangement. Each version must be a genuine design alternative.

The only files you may read are:
- The file you are currently writing (to verify)
- Shared files in `lib/widgets/`, `lib/themes/`, `lib/providers/` (foundation layer)
- Context files in `.claude/context/`

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

## Agent B — Screens batch 1 (Pages 1–3)

**⚠️ ISOLATION: Do NOT read any files from other version folders. Generate fresh design.**

**Files:**
```
lib/versions/vN/pages/buttons/buttons_page.buttons.dart
lib/versions/vN/pages/inputs/inputs_page.inputs.dart
lib/versions/vN/pages/controls/controls_page.controls.dart
```

**Instructions:**

Create these page files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — produce a **visually distinct layout** from any previous version. Do not read previous version files.

Use page specs from pages.md for:
- Page 1: `ButtonsPage` (StatefulWidget — needs `_selected`)
- Page 2: `InputsPage` (StatefulWidget — needs checkbox/radio/switch state)
- Page 3: `ControlsPage` (StatefulWidget — needs slider/dropdown state)

Use class names and import paths **exactly** as listed in class_manifest.md.
Follow naming_and_rules.md (no context.watch, 8dp grid, no hardcoded colors/sizes).
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Key StatefulWidget requirement:** `ButtonsPage`, `InputsPage`, and `ControlsPage` are all `StatefulWidget`. Ensure `createState()` and the `State` class are in the same file.

**Import rule:** Each file imports only what it directly uses. No unused imports.

---

## Agent C — Screens batch 2 (Pages 4–6)

**⚠️ ISOLATION: Do NOT read any files from other version folders. Generate fresh design.**

**Files:**
```
lib/versions/vN/pages/navigation/navigation_showcase_page.navigation.dart
lib/versions/vN/pages/stepper/stepper_showcase_page.stepper.dart
lib/versions/vN/pages/cards/cards_page.cards.dart
```

**Instructions:**

Create these page files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — visually distinct from previous versions. Do not read previous version files.

Use page specs from pages.md for:
- Page 4: `NavigationShowcasePage` (StatefulWidget — needs `_navIndex`)
- Page 5: `StepperShowcasePage` (StatefulWidget — needs `_vStep`, `_hStep`)
- Page 6: `CardsPage` (StatelessWidget)

Use class_manifest.md for all import paths. Follow naming_and_rules.md and design_principles.md.
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Note for NavigationShowcasePage:** The `DefaultTabController` wraps only the Column section for TabBar/TabBarView, not the whole Scaffold — the page itself has its own `Scaffold(AppBar(...))`.

**Note for NavigationRail preview height:** When rendering `NavigationRail` as a preview inside a scrollable Column, the wrapping `SizedBox` height must be ≥ `(72 × destinationCount) + 40`. For 3 destinations use `SizedBox(height: 256)` minimum — never `height: 200`. Using too small a value causes "BOTTOM OVERFLOWED BY N PIXELS" because `NavigationRailLabelType.all` stacks icon + label for every destination and the rail does not scroll.

**Note for StepperShowcasePage:** Guards for step bounds: `if (_vStep < 3) _vStep++` / `if (_vStep > 0) _vStep--`. Do not use `dart:math` — use conditional increments.

**Import rule:** Each file imports only what it directly uses.

---

## Agent D — Screens batch 3 (Pages 7–9)

**⚠️ ISOLATION: Do NOT read any files from other version folders. Generate fresh design.**

**Files:**
```
lib/versions/vN/pages/feedback/feedback_page.feedback.dart
lib/versions/vN/pages/chips/chips_page.chips.dart
lib/versions/vN/pages/lists/lists_page.lists.dart
```

**Instructions:**

Create these page files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — visually distinct from previous versions. Do not read previous version files.

Use page specs from pages.md for:
- Page 7: `FeedbackPage` (StatelessWidget — dialogs/sheets/snackbars use builder context, no local state)
- Page 8: `ChipsPage` (StatefulWidget — needs `_choice`, `_filters`, `_inputTags`)
- Page 9: `ListsPage` (StatelessWidget — uses `DefaultTabController`)

`ListsPage` wraps its entire widget tree in `DefaultTabController(length: 3, child: Scaffold(...))` — the `Scaffold` includes `AppBar` with `bottom: TabBar(...)` and `body: TabBarView(...)`.

Use class_manifest.md for imports. Follow naming_and_rules.md and design_principles.md.
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Import rule:** Each file imports only what it directly uses.

---

## Agent E — Screens batch 4 (Pages 10–12)

**⚠️ ISOLATION: Do NOT read any files from other version folders. Generate fresh design.**

**Files:**
```
lib/versions/vN/pages/media/media_page.media.dart
lib/versions/vN/pages/typography/typography_page.typography.dart
lib/versions/vN/pages/layout/layout_page.layout.dart
```

**Instructions:**

Create these page files for version `vN` of package `{PACKAGE_NAME}`.
Design iteration #{VERSION} — visually distinct from previous versions. Do not read previous version files.

Use page specs from pages.md for:
- Page 10: `MediaPage` (StatelessWidget — includes private `_HeroDetailPage` class in same file)
- Page 11: `TypographyPage` (StatelessWidget)
- Page 12: `LayoutPage` (StatelessWidget — includes private `_Box` helper widget in same file)

**Note for MediaPage:** `_HeroDetailPage` is a private `StatelessWidget` declared in the **same file** as `MediaPage`. This is acceptable per the "StatefulWidget + State in same file" convention for private implementation helpers. The Hero tag must be `'media-hero-demo'` in both widgets.

**Note for LayoutPage:** The `_Box` helper is a private function or small widget in the same file returning a styled `Container`. Keep it simple — a function `Widget _box(BuildContext context) => Container(...)` is fine.

Use class_manifest.md for imports. Follow naming_and_rules.md and design_principles.md.
Apply all DART/FLUTTER PITFALLS rules before writing each file.

**Import rule:** Each file imports only what it directly uses.

---

## Agent F — Shared widgets
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
- `Consumer<ThemeProvider>` wrapping a `PopupMenuButton<ThemeNames>`
- Use `child:` (not `icon:`) to display the active theme name alongside the icon:
  ```dart
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(_label(themeProvider.currentTheme), style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(width: 4),
      const Icon(Icons.palette_outlined),
      const SizedBox(width: 16),
    ],
  )
  ```
- `tooltip: 'Switch theme'`
- `onSelected`: `context.read<ThemeProvider>().setTheme(value)`
- `itemBuilder`: map all `ThemeNames.values` to `PopupMenuItem<ThemeNames>(value: t, child: Text(_label(t)))`
- Item labels via private `_label(ThemeNames t)` switch expression from themes.md

> **Why `PopupMenuButton` with `child:`, not `DropdownButton`:** `DropdownButton` in AppBar actions bypasses Flutter's trailing-edge padding, causing the icon to clip at the screen edge. `PopupMenuButton` solves alignment. Using `child:` (vs `icon:`) lets us display both the active theme name text and the palette icon together — matching the `DropdownButton` UX without its layout bugs.

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

## Agent G — Version navigator

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

Use all 12 `NavigationDrawerDestination` items and page instances from the **Navigator** section of pages.md.
Import all 12 page classes using `package:{PACKAGE_NAME}/versions/vN/pages/...` from class_manifest.md.
Import `ThemeDropdown` and `VersionSwitcher` from class_manifest.md.
