# Design System Doc Agent

## Purpose

After all page files are generated, this agent reads every page file for version `vN` and produces a structured design system document at:

```
lib/versions/vN/design_system_vN.md
```

This document captures the actual design decisions made in the code — spacing, typography usage, component choices, color roles — as authoritative reference for the version.

---

## Agent prompt template

> You are a design system documentation agent. Your job is to read the Flutter page files for version `vN`, extract the design decisions made, and write a structured design system document.
>
> **PACKAGE_NAME:** `{PACKAGE_NAME}` | **VERSION:** `{VERSION}`
>
> ---
> **Files to read (all newly generated pages for vN):**
> ```
> lib/versions/vN/pages/buttons/buttons_page.buttons.dart
> lib/versions/vN/pages/inputs/inputs_page.inputs.dart
> lib/versions/vN/pages/controls/controls_page.controls.dart
> lib/versions/vN/pages/navigation/navigation_showcase_page.navigation.dart
> lib/versions/vN/pages/stepper/stepper_showcase_page.stepper.dart
> lib/versions/vN/pages/cards/cards_page.cards.dart
> lib/versions/vN/pages/feedback/feedback_page.feedback.dart
> lib/versions/vN/pages/chips/chips_page.chips.dart
> lib/versions/vN/pages/lists/lists_page.lists.dart
> lib/versions/vN/pages/media/media_page.media.dart
> lib/versions/vN/pages/typography/typography_page.typography.dart
> lib/versions/vN/pages/layout/layout_page.layout.dart
> lib/versions/vN/version_vN_navigator.dart
> ```
>
> ---
> **Instructions:**
>
> 1. Read every file listed above using the Read tool.
> 2. Analyze the code for: layout structure, spacing values, color roles used, text theme roles used, component variants chosen, and any notable design decisions.
> 3. Write `lib/versions/vN/design_system_vN.md` using the output format below.
> 4. **Do NOT modify any `.dart` files** — this agent is read-only except for writing the final `.md` file.

---

## Output format

Write `lib/versions/vN/design_system_vN.md` with exactly this structure (fill in from code analysis):

```markdown
# Design System — v{VERSION}

> Auto-generated from v{VERSION} source files. Describes the actual design decisions implemented.

---

## Visual Identity

[2–3 sentences describing the design personality of this version — density, spacing rhythm, visual weight, tone. Derived from observed layout patterns in the code.]

---

## Design Tokens

### Spacing & Layout

| Token | Value | Used in |
|---|---|---|
| Page margin | [e.g. 16dp] | All page bodies |
| Section spacing | [e.g. 24dp between sections] | All pages |
| Card inner padding | [observed value] | Cards page |
| Row/column gap | [observed SizedBox heights] | Buttons, Inputs |
| Grid base | 8dp | All |

### Typography Roles Active in This Version

| Role | Representative usage |
|---|---|
| `displayLarge` | [which page/context] |
| `titleLarge` | [which page/context] |
| `titleMedium` | [which page/context] |
| `titleSmall` | [which page/context] |
| `bodyLarge` | [which page/context] |
| `bodyMedium` | [which page/context] |
| `bodySmall` | [which page/context] |
| `labelLarge` | [which page/context] |
| `labelSmall` | [which page/context] |

### Color Roles Active in This Version

| Role | Representative usage |
|---|---|
| `colorScheme.primary` | [what it's used for] |
| `colorScheme.onPrimary` | [what it's used for] |
| `colorScheme.surface` | [what it's used for] |
| `colorScheme.surfaceContainer` | [what it's used for] |
| `colorScheme.surfaceContainerHighest` | [what it's used for] |
| `colorScheme.primaryContainer` | [what it's used for] |
| `colorScheme.outline` | [what it's used for] |
| `colorScheme.onSurfaceVariant` | [what it's used for] |

### Shape Usage

| Component type | Shape | Notes |
|---|---|---|
| Buttons | Full pill (default MD3) | — |
| Cards | [observed borderRadius] | [any variants] |
| Input fields | [observed] | — |
| Chips | [observed] | — |
| Other notable shapes | [any custom uses] | — |

---

## Component Inventory

| Category | Page | Components Demonstrated |
|---|---|---|
| Buttons | Buttons | ElevatedButton, FilledButton, FilledTonalButton, OutlinedButton, TextButton, IconButton (4 variants), FAB (small/std/large/extended), SegmentedButton |
| Inputs | Inputs | TextField (6 variants), CheckboxListTile, RadioListTile, SwitchListTile |
| Controls | Controls | Slider, RangeSlider, discrete Slider, DropdownButtonFormField, DropdownMenu, Autocomplete |
| Navigation | Navigation | TabBar + TabBarView, NavigationRail, NavigationBar, SliverAppBar + FlexibleSpaceBar |
| Stepper | Stepper | Stepper (vertical 4-step), Stepper (horizontal 3-step) |
| Cards | Cards | Card (elevated/filled/outlined/tappable), ListTile (3 variants), ExpansionTile |
| Feedback | Feedback | CircularProgressIndicator (×3), LinearProgressIndicator (×2), AlertDialog, SimpleDialog, Dialog.fullscreen, ModalBottomSheet, SnackBar (×2), Tooltip (×5) |
| Chips | Chips | Chip, InputChip, ChoiceChip, FilterChip, ActionChip, AssistChip |
| Lists | Lists & Data | ListView.builder, GridView.builder, DataTable |
| Media | Media & Icons | CircleAvatar, ClipRRect, ClipOval, Hero, Icon gallery, icon size scale |
| Typography | Typography | All 15 MD3 type scale roles |
| Layout | Layout | Row (6 alignments), Wrap, Stack, spacing grid, Divider variants, Card elevation scale |

---

## Accessibility Coverage

- [ ] All `IconButton` widgets include `tooltip:` parameter
- [ ] All `FloatingActionButton` widgets include `tooltip:` parameter
- [ ] `CircleAvatar` widgets representing people have semantic labels where needed
- [ ] `Hero` transitions use consistent tags between source and destination
- [ ] `ProgressIndicator` widgets are accessible (platform renders semantic)
- [ ] Minimum 48×48dp touch targets maintained throughout

[Add any specific notes found during code review.]

---

## Design Rationale

[3–4 sentences explaining what makes this version's design approach unique compared to a generic implementation. Focus on: how sections are visually separated, the density/airiness of the layout, any distinctive structural choices in how content is organized on each page, and the overall aesthetic personality.]
```

---

## Notes

- Write the file using the Write tool to `lib/versions/vN/design_system_vN.md`
- Replace `vN` and `{VERSION}` with the actual version (e.g. `v2`, `2`)
- Fill in every `[bracketed placeholder]` from actual code evidence — no guessing
- If a color role or text style is not observed in any file, write `— not used in this version`
- The accessibility checklist items should be marked `[x]` (pass) or `[ ]` (not confirmed) based on code review
