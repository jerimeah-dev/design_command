# Design System — v1

> Auto-generated from v1 source files. Describes the actual design decisions implemented.

---

## Visual Identity

Version 1 follows a clean, moderately airy Material Design 3 aesthetic. A consistent 16dp page margin and 24dp section spacing rhythm give each page a comfortable breathing room without excessive whitespace. Visual weight is medium — sections are separated by labeled headings in `labelLarge` tinted with `colorScheme.primary` rather than by heavy dividers or card wrappers, keeping the hierarchy light and scannable.

---

## Design Tokens

### Spacing & Layout

| Token | Value | Used in |
|---|---|---|
| Page margin | 16dp (`EdgeInsets.all(16)`) | All page bodies (Buttons, Inputs, Controls, Cards, Feedback, Chips, Media, Typography, Layout, Navigation) |
| Section spacing | 24dp (`SizedBox(height: 24)`) | Between every major section across all pages |
| Card inner padding | 16dp (`EdgeInsets.all(16)`) | Cards page (all card variants), Bottom Sheet, Media hero |
| Row/column gap (tight) | 8dp (`SizedBox(height: 8)`) | Between items within a section (button list, icon buttons, chip rows) |
| Row/column gap (medium) | 16dp (`SizedBox(height: 16)`) | Between text fields in Inputs, between progress rows in Feedback |
| Wrap item spacing | 8dp (`spacing: 8, runSpacing: 8`) | Chip groups, dialog buttons, snackbar buttons |
| Stepper section header | `EdgeInsets.fromLTRB(16, 16, 16, 8)` | Stepper page section labels |
| Grid base | 8dp | All |

### Typography Roles Active in This Version

| Role | Representative usage |
|---|---|
| `displayLarge` | Typography page — full type scale showcase |
| `displayMedium` | Typography page — full type scale showcase |
| `displaySmall` | Typography page — full type scale showcase |
| `headlineLarge` | Typography page — full type scale showcase |
| `headlineMedium` | Typography page — full type scale showcase |
| `headlineSmall` | Typography page — full type scale showcase |
| `titleLarge` | Media page — Hero detail view heading |
| `titleMedium` | Cards page — card titles (Elevated, Filled, Outlined card headers); Bottom Sheet options header |
| `titleSmall` | Cards page — tappable card label, ListTile titles, ExpansionTile titles; Stack center label; Layout elevation values |
| `bodyLarge` | Navigation page — NavigationRail content area; Feedback page — full-screen dialog body |
| `bodyMedium` | Controls page — slider value labels; Navigation page — TabBarView content, SliverAppBar body text; Stepper step content; Cards page — card body text; Feedback page — dialog content, SimpleDialog options; Media page — hero card caption |
| `bodySmall` | Cards page — ListTile subtitles; Lists page — list item subtitles; Chips page — selection state labels |
| `labelLarge` | All pages — section headings (tinted with `colorScheme.primary`) |
| `labelMedium` | Typography page — full type scale showcase |
| `labelSmall` | Feedback page — progress indicator captions; Typography page — type role name labels (tinted `colorScheme.outline`); Layout page — alignment name labels, spacing grid captions, divider labels; Lists page — grid cell numbers; Chips page — not directly, icon sizes annotated |

### Color Roles Active in This Version

| Role | Representative usage |
|---|---|
| `colorScheme.primary` | Section heading text color (all pages); FAB default color; icon button filled variant; tappable card icon; media icon gallery icons; CircleAvatar icon star scale; ExpansionTile leading icons; ListTile star icon tint |
| `colorScheme.onPrimary` | — not directly used in page code (applied implicitly by filled button and FAB widget internals) |
| `colorScheme.surface` | TabBar background in Navigation page (`Material(color: colorScheme.surface)`) |
| `colorScheme.surfaceContainer` | Lists page — grid alternating cell background (odd cells) |
| `colorScheme.surfaceContainerHighest` | Cards page — filled card background; Navigation page — SliverAppBar FlexibleSpaceBar background; Layout page — Row alignment demo containers, Stack background; Lists page — grid alternating cell background (even cells); Media page — ClipRRect placeholder |
| `colorScheme.primaryContainer` | Layout page — spacing grid demo boxes and `_box` helper; Media page — CircleAvatar backgrounds (size scale and primary icon variant) |
| `colorScheme.outline` | Cards page — outlined card border; Layout page — thick divider color, label text tint; Typography page — type role name label tint |
| `colorScheme.onSurfaceVariant` | Chips page — selected state caption text (`bodySmall`) |
| `colorScheme.secondary` | Feedback page — 100% circular progress indicator color override |
| `colorScheme.secondaryContainer` | Media page — ClipOval placeholder; CircleAvatar secondary icon variant |
| `colorScheme.tertiaryContainer` | Layout page — Wrap layout demo boxes; Media page — ClipRRect small-radius placeholder; CircleAvatar tertiary icon variant |
| `colorScheme.onSurface` | Typography page — all specimen text color; Media page — icon gallery icon color |
| `colorScheme.errorContainer` | Feedback page — error SnackBar background |
| `colorScheme.tertiary` | Cards page — star icon on three-line ListTile |

### Shape Usage

| Component type | Shape | Notes |
|---|---|---|
| Buttons | Full pill (default MD3 StadiumBorder) | ElevatedButton, FilledButton, OutlinedButton, TextButton all default |
| Cards (elevated) | Default MD3 rounded rect (approx. 12dp) | Default Card widget shape |
| Cards (outlined) | `BorderRadius.circular(12)` + `BorderSide(color: colorScheme.outline)` | Explicitly set on outlined variant |
| Cards (tappable InkWell) | `BorderRadius.circular(12)` | Set on InkWell to match card shape |
| Input fields | Default MD3 filled input decoration (rounded) | No custom shape overrides; `OutlineInputBorder()` used on DropdownButtonFormField |
| Chips | Default MD3 stadium shape | All chip variants use Flutter defaults |
| Clipped media (large) | `BorderRadius.circular(12)` | ClipRRect in Media page |
| Clipped media (small) | `BorderRadius.circular(4)` | ClipRRect tight-radius variant in Media page |
| Layout demo boxes | `BorderRadius.circular(8)` | `_box()` helper and Wrap layout containers |
| Stack background | `BorderRadius.circular(12)` | Stack demo container in Layout page |
| Hero detail card margin | `EdgeInsets.all(32)` | Card in `_HeroDetailPage` |

---

## Component Inventory

| Category | Page | Components Demonstrated |
|---|---|---|
| Buttons | Buttons | ElevatedButton, FilledButton, FilledButton.tonal, OutlinedButton, TextButton, IconButton (standard/filled/filledTonal/outlined — 4 variants), FloatingActionButton (small/standard/large/extended — 4 variants), SegmentedButton |
| Inputs | Inputs | TextField (standard, email with prefixIcon, password with suffixIcon + toggle, multiline, validation error, disabled — 6 variants), CheckboxListTile (3: unchecked/checked/tristate), RadioListTile (3 choices via RadioGroup), SwitchListTile (2) |
| Controls | Controls | Slider (continuous), RangeSlider, Slider (discrete with divisions + label), DropdownButtonFormField (with OutlineInputBorder), DropdownMenu, Autocomplete |
| Navigation | Navigation | TabBar + TabBarView (3 tabs), NavigationRail (labelType.all, 3 destinations), NavigationBar (4 destinations), SliverAppBar + FlexibleSpaceBar (pinned, expandedHeight 120) |
| Stepper | Stepper | Stepper vertical (4-step: Account/Profile/Preferences/Confirm), Stepper horizontal (3-step: Details/Payment/Review) |
| Cards | Cards | Card elevated (default), Card filled (elevation:0, surfaceContainerHighest), Card outlined (elevation:0, outline border, borderRadius 12), Card tappable (InkWell + borderRadius 12), ListTile standard, ListTile with CircleAvatar + trailing IconButton, ListTile three-line, ExpansionTile (×3) |
| Feedback | Feedback | CircularProgressIndicator indeterminate, CircularProgressIndicator 70%, CircularProgressIndicator 100% (secondary color, sized 40×40), LinearProgressIndicator indeterminate, LinearProgressIndicator 40%, AlertDialog (TextButton + FilledButton actions), SimpleDialog (3 options), Dialog.fullscreen (Scaffold + CloseButton), showModalBottomSheet (256dp, 3 ListTiles), SnackBar with action, SnackBar error (errorContainer bg) with action, Tooltip ×4 on icons, Tooltip on Chip |
| Chips | Chips | Chip (simple/with avatar/with icon/deletable), InputChip (removable tags list), ChoiceChip (single-select, 4 options), FilterChip (multi-select, 6 options), ActionChip (×4 with icons), ActionChip rendered as AssistChip (×3 with icons) |
| Lists | Lists & Data | ListView.builder (15 items with CircleAvatar + chevron), GridView.builder (24 items, 3-column, 2dp gaps, alternating surface colors), DataTable (5 columns, 8 rows) |
| Media | Media & Icons | CircleAvatar size scale (radii: 16/24/32/40/56dp), CircleAvatar color variants (primaryContainer/secondaryContainer/tertiaryContainer), ClipRRect borderRadius:12, ClipOval, ClipRRect borderRadius:4, Hero animation (tag: 'media-hero-demo') with push-route detail page, Icon gallery (20 icons at size 24, onSurface color), Icon size scale (16/24/32/48/64dp) |
| Typography | Typography | All 15 MD3 type scale roles: displayLarge/Medium/Small, headlineLarge/Medium/Small, titleLarge/Medium/Small, bodyLarge/Medium/Small, labelLarge/Medium/Small |
| Layout | Layout | Row with 6 MainAxisAlignment variants (start/center/end/spaceBetween/spaceAround/spaceEvenly), Wrap (variable-width items, spacing:8/runSpacing:8), Stack with Positioned widgets, 8dp spacing grid visualization (8/16/24/32/48dp), Divider (default/thick 2dp/indented 32dp), VerticalDivider, Card elevation scale (0/1/2/4/8) |

---

## Navigation Shell

The `VersionV1Navigator` uses a responsive `LayoutBuilder` with a `NavigationDrawer` shell (12 destinations). At `maxWidth >= 1200dp` the drawer is always-visible in a side `Row`; below that breakpoint it collapses to a hamburger-accessible modal drawer. Page content is preserved across navigation switches via `IndexedStack`. The app bar exposes `ThemeDropdown` and `VersionSwitcher` actions on all breakpoints.

---

## Accessibility Coverage

- [x] All `IconButton` widgets include `tooltip:` parameter — confirmed in ButtonsPage (standard, filled, tonal, outlined variants) and CardsPage (trailing `more_vert` button)
- [x] All `FloatingActionButton` widgets include `tooltip:` parameter — confirmed: small (`'Small FAB'`), standard (`'Standard FAB'`), large (`'Large FAB'`), extended (`'Extended FAB'`)
- [x] `Hero` transitions use consistent tags between source and destination — tag `'media-hero-demo'` appears in both `MediaPage` source widget and `_HeroDetailPage` destination widget
- [x] `ProgressIndicator` widgets are accessible — standard `CircularProgressIndicator` and `LinearProgressIndicator` used; MD3 defaults provide semantic accessibility
- [x] Minimum 48×48dp touch targets maintained throughout — all interactive widgets (buttons, list tiles, FABs, chips) are MD3 components which enforce 48dp minimum touch targets by default; password visibility toggle `IconButton` includes `tooltip`
- [ ] `AssistChip` rendered as `ActionChip` — the code uses `ActionChip` to represent the AssistChip section; a semantic note for future versions to use the dedicated `AssistChip` widget
- [ ] `DropdownMenu` and `Autocomplete` fields do not have explicit `semanticsLabel` set — relies on `labelText` inside `InputDecoration` for screen reader labeling

---

## Design Rationale

Version 1 is a comprehensive reference build that prioritizes legibility and component breadth over decorative styling. Every page uses the same structural grammar — a `labelLarge` + `colorScheme.primary` section header followed by an 8dp gap and then the component group, with 24dp breathing space between sections — creating a consistent internal rhythm that makes the showcase easy to navigate. The design deliberately avoids custom theming overrides, letting MD3 defaults express the system's full capability, which means the entire showcase adapts cleanly to any seed color or brightness mode without per-component adjustments. The responsive `NavigationDrawer` shell (persistent at ≥1200dp, modal below) and the exclusive use of `IndexedStack` for page preservation reflect an architectural preference for stateful navigation fidelity over simplicity, appropriate for a design reference tool that users will jump around in frequently.
