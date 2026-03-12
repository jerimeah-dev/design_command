# Flutter Social Media Design Showcase — Command Reference

## What This Project Is

A Claude Code slash command (`/project:create-soc-med-design`) that generates a complete Flutter social media design showcase inside any Flutter project. Each run produces a new design version. All versions coexist and are switchable at runtime.

---

## Folder Structure (this project)

```
design_command/
  plan.md                            ← this file
  CLAUDE.md                          ← coding rules for this project
  design_principles.md               ← full MD3 design guide (human-readable source)

  .claude/
    commands/
      create-soc-med-design.md       ← the slash command (execution steps only)
    context/
      design_principles.md           ← MD3 rules (embedded by agents when generating)
      naming_and_rules.md            ← naming conventions + provider rules
      class_manifest.md              ← canonical class names + import paths
      themes.md                      ← 10 theme seed-color definitions
      pages.md                       ← 10 page content specifications
```

> **To use in a Flutter project:** Copy the entire `.claude/` folder into your Flutter project root.

---

## How to Use the Command

1. Create a Flutter project: `flutter create my_app`
2. Add provider: `flutter pub add provider`
3. Copy `.claude/` from this project → `my_app/.claude/`
4. Open `my_app` in Claude Code
5. Run `/project:create-soc-med-design`
6. Claude generates all `lib/` files
7. Run `flutter run`

Run the command again at any time to generate a new design version.

---

## Generated `lib/` Structure

```
lib/
  main.dart
  app.dart                           ← MultiProvider + Consumer<ThemeProvider> → MaterialApp

  providers/
    theme_provider.dart              ← ThemeProvider (ChangeNotifier)
    version_provider.dart            ← VersionProvider (ChangeNotifier)

  themes/
    theme_names.dart                 ← ThemeNames enum (10 values)
    app_themes.dart                  ← AppThemes.of(ThemeNames) → ThemeData via fromSeed

  widgets/
    theme_dropdown.dart              ← Consumer<ThemeProvider>, global theme switcher
    version_switcher.dart            ← Consumer<VersionProvider>, hidden if only 1 version
    adaptive_nav_scaffold.dart       ← NavigationBar/Rail/Drawer by screen width

  versions/
    version_registry.dart            ← maps int → VersionConfig (label + scaffold factory)
    v1/
      version_v1_navigator.dart      ← NavigationDrawer listing all 10 pages for v1
      screens/
        splash/          splash_page.splash.dart
        login/           login_page.login.dart  +  login_form_widget.login.dart
        home/            home_page.home.dart    +  feed_item_widget.home.dart
        profile/         profile_page.profile.dart  +  profile_stats_widget.profile.dart
        notifications/   notifications_page.notifications.dart  +  notification_item_widget.notifications.dart
        messages/        messages_page.messages.dart  +  message_item_widget.messages.dart
        explore/         explore_page.explore.dart  +  search_bar_widget.explore.dart
        create_post/     create_post_page.create_post.dart  +  media_picker_widget.create_post.dart
        story/           story_page.story.dart  +  story_progress_widget.story.dart
        settings/        settings_page.settings.dart  +  settings_item_widget.settings.dart
    v2/  (same structure on second run)
    v3/  (same structure on third run)
```

---

## Runtime Features

### Theme Switching
- `ThemeDropdown` in every page's AppBar → 10 themes, switches instantly app-wide
- Selecting a theme calls `context.read<ThemeProvider>().setTheme(t)` → `notifyListeners()` → `Consumer<ThemeProvider>` in `app.dart` rebuilds `MaterialApp.theme` → all pages re-render
- No `context.watch` anywhere — `Consumer` handles all reactivity

### Version Switching
- `VersionSwitcher` chip row (V1, V2, …) auto-appears once 2+ versions exist
- Tapping a chip calls `context.read<VersionProvider>().setVersion(n)` → rebuilds root → shows different version's pages
- Active theme is preserved when switching versions

### Page Navigation
- All 10 pages accessible via `NavigationDrawer` in each version's navigator
- Adaptive nav scaffold also provides `NavigationBar` (phone) / `NavigationRail` (tablet) / `NavigationDrawer` (desktop) for the 5 primary destinations

### Re-running the Command
- Detects existing `lib/versions/v*/` count → generates vN+1
- Never modifies existing version folders
- Updates `version_registry.dart` with new version entry
- `VersionSwitcher` automatically shows the new version chip on next app launch

---

## Theme System

| # | Name | Seed Color | Mode |
|---|---|---|---|
| 1 | Pure White | `Color(0xFF9E9E9E)` | Light |
| 2 | Soft White | `Color(0xFFBCAAA4)` | Light |
| 3 | Cool Gray | `Color(0xFF78909C)` | Light |
| 4 | Warm Cream | `Color(0xFFA1887F)` | Light |
| 5 | Slate | `Color(0xFF546E7A)` | Light |
| 6 | Charcoal | `Color(0xFF546E7A)` | Dark |
| 7 | Pure Black | `Color(0xFF9E9E9E)` | Dark |
| 8 | Warm Dark | `Color(0xFFA1887F)` | Dark |
| 9 | Paper | `Color(0xFFD4C4B0)` | Light |
| 10 | Blueprint | `Color(0xFF607D8B)` | Light |

All themes use `ColorScheme.fromSeed()` — no hardcoded hex colors in widget trees.

**To update a theme:** Edit only `lib/themes/app_themes.dart` → change the seed color or brightness.
**To add a theme:** Add to `ThemeNames` enum + add `case` in `AppThemes.of()` + update `ThemeDropdown._label()`.

---

## Key Rules

| Rule | What it means |
|---|---|
| No `context.watch` | Use `Consumer<T>` or `Selector<T,R>` for reactive UI |
| 1 file per class | StatefulWidget + State share one file |
| File naming | `{className_snake}.{folderName}.dart` |
| Shared widgets | `{className_snake}.dart` in `lib/widgets/` |
| No hardcoded colors | Always `Theme.of(context).colorScheme.*` |
| No hardcoded sizes | Always `Theme.of(context).textTheme.*` |
| 8dp spacing grid | All padding/margins multiples of 8dp |
| Existing versions never modified | Each run only appends a new version |

---

## Customizing the Command

All context files live in `.claude/context/`. Edit them to change how future versions are generated:

| File | What to edit |
|---|---|
| `context/design_principles.md` | Change the MD3 design rules |
| `context/themes.md` | Change seed colors, add/remove themes |
| `context/pages.md` | Change page layouts and mock content |
| `context/class_manifest.md` | Update if you rename classes |
| `context/naming_and_rules.md` | Change coding conventions |

---

## Verification Checklist

After running the command in a Flutter project:

- [ ] `flutter analyze` → 0 errors
- [ ] App launches and shows first page
- [ ] Theme dropdown switches all pages instantly
- [ ] All 10 pages accessible via drawer
- [ ] `grep -r "context.watch" lib/` → 0 results
- [ ] `grep -r "Color(0x" lib/` → 0 results
- [ ] Second command run creates `lib/versions/v2/` without touching v1
- [ ] `VersionSwitcher` appears after second run and toggles versions correctly
