# Material Design 3 — Flutter Design Guidelines

You are designing a Flutter app. These are your design laws. Follow them at all times.

---

## The Three Principles

Every decision you make must serve one of these three goals:

**Personal.** The UI feels like it was made for the user. Color adapts to their context. The experience is warm, not generic.

**Adaptive.** The layout works beautifully at every screen size — phone, tablet, foldable, desktop. Nothing breaks. Nothing feels cramped or stretched.

**Expressive.** Shape, motion, color, and type carry meaning. The interface has personality. It communicates, not just displays.

---

## Color

Color is the strongest signal you have. Use it with intention.

**Generate, don't pick.** Always derive the full color scheme from a single seed color using `ColorScheme.fromSeed()`. Never manually assemble a palette from hex values. The algorithm guarantees harmony, contrast, and adaptability across light and dark modes.

```dart
ColorScheme.fromSeed(seedColor: brandColor, brightness: Brightness.light)
```

**Use roles, not raw values.** Every color has a role — `primary`, `surface`, `error`, `tertiary`. Use `Theme.of(context).colorScheme.primary`, never `Color(0xFF6750A4)` inside a widget. When the theme changes, your UI updates automatically.

**Respect the pairing system.** Every surface color has a matching `onX` color for text and icons on top of it. `onPrimary` goes on `primary`. `onSurface` goes on `surface`. `onErrorContainer` goes on `errorContainer`. Never mix them across surfaces — and never use `error` as a large background fill (it is designed for borders and icons, not surfaces); use `errorContainer` instead.

**Reserve `primary` for what matters most.** Primary color draws the eye. Use it on the single most important interactive element per screen — the main action, the active state, the FAB. If everything is primary, nothing is.

**Support both light and dark.** Always define both `theme` and `darkTheme` in `MaterialApp`. Use the same seed for both. Never ship a Flutter app with only a light theme.

**Never convey meaning through color alone.** Pair color with an icon, label, or shape. A red border alone is not an error state — add an error icon and message too.

---

## Typography

Type is hierarchy made visible. M3 gives you a precise scale — use it.

The scale has five categories, each with Large, Medium, and Small variants:

- **Display** — Hero moments only. Splash screens, onboarding. Never for UI chrome.
- **Headline** — Primary screen titles. One per screen.
- **Title** — Card headings, dialog titles, section labels.
- **Body** — All readable paragraph and description text. Default to `bodyMedium`.
- **Label** — Buttons, captions, badges, overlines. Button text is always `labelLarge`.

Access them in Flutter:

```dart
Theme.of(context).textTheme.bodyMedium
Theme.of(context).textTheme.titleLarge
Theme.of(context).textTheme.labelLarge // for all button text
```

**Never hardcode font sizes.** Use the text theme. This ensures type scales correctly with the user's system text size setting.

**Support text scaling up to 200%.** Wrap constrained containers with flexible layout — `Flexible`, `Expanded`, or `FittedBox` — so text never clips when the user enlarges it.

**Establish hierarchy through the scale, not weight alone.** Reach for a smaller type role before you reach for bold. A `titleMedium` communicates hierarchy more clearly than bold `bodyMedium`.

---

## Shape

Shape is M3's personality system. It creates rhythm, depth, and softness across the interface.

The shape scale in Flutter maps to `ShapeBorder` values:

| Role | Corner Radius | Use |
|---|---|---|
| Extra Small | 4dp | Tooltips, small chips |
| Small | 8dp | Chips, text field corners |
| Medium | 12dp | Cards |
| Large | 16dp | Bottom sheets, navigation drawers |
| Extra Large | 28dp | Dialogs, large modals |
| Full | 50% (pill) | Buttons, FABs, search bars |

**Assign shapes by component role, not by preference.** Buttons are always pills. Cards are always medium-rounded. Dialogs are extra-large. These are not stylistic choices — they are the visual grammar of M3.

**Variation creates rhythm.** Do not apply one corner radius to everything. The contrast between a pill-shaped button and a medium-rounded card is intentional and meaningful.

**Avoid sharp corners.** Zero-radius corners are a deliberate brand statement. Do not use them by default — M3's aesthetic is intentionally soft and approachable.

---

## Elevation

Elevation communicates layering. In M3, elevation is expressed through **tonal color**, not shadows.

As a surface rises in elevation, it receives a tint derived from `primary`. This is handled automatically by Flutter's M3 `Material` widget. The six elevation levels are:

- **Level 0** — Flat. Backgrounds, filled buttons.
- **Level 1** — Slightly raised. Cards, bottom sheets resting.
- **Level 2** — Menus, navigation bars, chips.
- **Level 3** — FAB, dialogs.
- **Level 4** — Navigation drawers.
- **Level 5** — Modal bottom sheets at peak.

**Prefer tonal elevation over drop shadows.** Shadows are acceptable when two overlapping elements need stronger visual separation, but they should not be your first tool.

**Never invent elevation values.** Use Flutter's `elevation:` parameter on Material components — it maps directly to M3 levels. Do not write custom `BoxShadow` decorations unless you have no other option.

**Overlapping elements must be visually separated.** A FAB and a Snackbar should never cover each other without one of them moving. Elevation must always communicate a clear stacking order.

---

## Motion

Motion explains the interface. It shows where things came from, where they went, and that an action was received. It is never decoration.

**Every animation must have a reason.** If you cannot explain what information the animation communicates, remove it.

Use Flutter's built-in M3 transitions:

- **`PageTransitionsTheme` with `ZoomPageTransitionsBuilder`** — For screen-to-screen navigation.
- **`AnimatedSwitcher`** — For content swapping within a screen.
- **Hero** — For shared elements that persist between screens.
- **`TweenAnimationBuilder`** — For state-driven property changes.

**Duration guidelines:**
- Micro-interactions (ripple, toggle): 50–200ms
- Component transitions (expand, collapse): 200–500ms
- Screen-level transitions: 300–500ms

**Easing guidelines:**
- Elements entering the screen: decelerate (fast start, slow finish)
- Elements leaving the screen: accelerate (slow start, fast exit)
- State changes within the screen: standard easing

**Always respect the user's motion preferences.** Check `MediaQuery.of(context).disableAnimations`. If true, skip or snap animations — never play them at reduced speed.

---

## Layout and Adaptivity

A Flutter app runs on phones, tablets, foldables, and desktops. Your layout must work on all of them.

**Use the 8dp spacing grid.** All padding, margins, gaps, and component sizes must be multiples of 8dp. Use 4dp only for fine adjustments within components. Never use arbitrary values like 13dp or 22dp.

**Choose navigation by screen width:**

| Screen width | Navigation pattern | Flutter widget |
|---|---|---|
| Compact (< 600dp) | Bottom navigation bar | `NavigationBar` |
| Medium (600–1200dp) | Navigation rail | `NavigationRail` |
| Expanded (> 1200dp) | Navigation drawer | `NavigationDrawer` |

Switch between these at runtime using `LayoutBuilder` or `MediaQuery`. Never lock a phone layout onto a tablet.

**Bottom navigation requires 3–5 destinations.** Never fewer than 3. Never more than 5.

**For large screens, use adaptive layouts:**
- List + Detail side by side (email, files, messaging)
- Main content + Supporting panel (comments, related info)

Use `NavigationDrawer` persistently on expanded screens — never collapse it behind a hamburger icon on wide layouts.

---

## Images & Alignment

Images are layout citizens. They must follow the same grid, component, and accessibility rules as every other element.

**Follow the 8dp grid.** All image margins, padding, and spacing must be multiples of 8dp. Images are not exempt from the spacing grid — misaligned images break visual rhythm just as misaligned text does.

**Respect component layout.** Place images consistently inside Cards, Buttons, ListTiles, and other M3 components. Never offset or manually nudge images outside a component's layout rules using arbitrary `Positioned`, `Transform`, or negative padding hacks.

**Maintain responsive alignment.** Images must scale and align predictably across phones, tablets, and desktops. Use `Flexible`, `Expanded`, or `FittedBox` — never hardcode image dimensions that break on other screen sizes.

```dart
FittedBox(fit: BoxFit.cover, child: Image.asset(...))
Expanded(child: AspectRatio(aspectRatio: 16 / 9, child: Image.network(...)))
```

**Pair with text or icons intentionally.** Images that convey meaning must align with their labels or icons. Never rely on image position alone to communicate information — always pair a meaningful image with a visible label or accessible semantic.

**Support text scaling.** Images must not overlap or misalign when the user's text size increases up to 200%. Use flexible layout — `Flexible`, `Expanded`, `IntrinsicHeight` — so enlarged text reflows around images rather than colliding with them.

**Respect motion & transitions.** Animated images (e.g., `Hero` shared-element transitions) must maintain alignment during entry, exit, and mid-transition states. Set `Hero` tags on both source and destination widgets and verify alignment holds at every breakpoint.

**Accessibility alignment.** Semantic images (those that convey meaning) must stay visually aligned with their captions, labels, or interactive elements — misalignment breaks the relationship for low-vision users. Decorative images must use `Semantics(excludeSemantics: true)` and must not disrupt grid alignment.

```dart
// Semantic image — carries meaning
Semantics(label: 'User avatar for @username', child: CircleAvatar(...))

// Decorative image — purely visual
Semantics(excludeSemantics: true, child: Image.asset('assets/bg_texture.png'))
```

---

## Components

When Flutter provides an M3 component, always use it. Never build a custom replacement unless the M3 component genuinely cannot meet the requirement.

**Buttons** have five levels of emphasis. Choose by hierarchy, not aesthetics:
- `FilledButton` — The primary action. One per screen region maximum.
- `FilledTonalButton` — Secondary action when Filled is too dominant.
- `ElevatedButton` — Low-emphasis action that needs to stand out from the background.
- `OutlinedButton` — Medium-emphasis, often paired with a FilledButton.
- `TextButton` — Lowest emphasis. Tertiary or inline actions only.

**FloatingActionButton** is the primary or most frequent action on the screen. Use one per screen. It must not permanently obscure content — animate it out of the way when a bottom sheet rises.

**Cards** come in three variants — `elevated`, `filled`, `outlined`. Default to `elevated`. If a card is tappable, it must respond to hover, focus, and press states. Never make a tappable card that looks static.

**Dialogs** are for critical, blocking decisions only. Use them sparingly. Maximum two actions. Always dismissible by tapping the scrim or pressing Escape/Back.

**TextFields** always show a persistent label — never placeholder text alone. The error state requires both `errorText` below the field and the `error` color on the border.

---

## Accessibility

Accessibility is not a feature. It is a baseline requirement. Every screen must meet all of these.

**Touch targets:** Every interactive element must be at least 48×48dp. If the visual size is smaller, wrap it in a `SizedBox` or use `MaterialTapTargetSize.padded`. Space adjacent targets at least 8dp apart.

**Contrast:** Body text must meet 4.5:1 contrast against its background. Large text (18sp+) and UI component outlines must meet 3:1. `ColorScheme.fromSeed` meets these requirements automatically — do not override colors in ways that break contrast.

**Semantics:** Every interactive element needs a semantic label. Icon-only buttons must have `Semantics(label: '...')` or `IconButton(tooltip: '...')`. Images that carry meaning need `Semantics(label: '...')`. Purely decorative images need `Semantics(excludeSemantics: true)`.

**Text scaling:** Never hardcode font sizes. Never clip text containers without a scroll fallback. Test every screen at 200% text scale.

**Focus order:** Ensure tab/directional focus flows in logical reading order. Use `FocusTraversalGroup` to control focus scope when needed. Never suppress the visible focus indicator.

**Motion sensitivity:** Always check `MediaQuery.disableAnimations` and skip non-essential animations when it is true.

---

## The Rules at a Glance

| Always | Never |
|---|---|
| Use `ColorScheme.fromSeed` | Hardcode hex colors in widgets |
| Read colors from `Theme.of(context).colorScheme` | Use `Color(0xFF...)` inside widget trees |
| Use the M3 text theme for all type styles | Hardcode font sizes |
| Use 8dp multiples for all spacing | Use arbitrary spacing values |
| Use tonal elevation via Flutter's `elevation:` param | Write custom `BoxShadow` decorations |
| Assign shapes by component role (buttons = pill, cards = medium) | Apply one corner radius to everything |
| Provide both `theme` and `darkTheme` | Ship a light-only app |
| Give every interactive element a 48×48dp touch target | Make tap targets smaller than 48dp |
| Add semantic labels to all interactive and meaningful elements | Leave icon-only buttons without labels |
| Respect `MediaQuery.disableAnimations` | Play animations for users who have disabled them |
| Use `NavigationBar`, `NavigationRail`, or `NavigationDrawer` based on screen width | Lock a single navigation pattern across all screen sizes |
| Use Flutter's built-in M3 components | Build custom replacements when M3 components exist |
| Animate with purpose — every motion must communicate something | Add decorative animations with no informational value |
| Use 8dp multiples for all image margins, padding, and spacing | Apply arbitrary image offsets outside the spacing grid |
| Place images inside M3 component layout rules (Card, ListTile, etc.) | Manually nudge or offset images outside component bounds |
| Use `Flexible`, `Expanded`, or `FittedBox` to keep images responsive | Hardcode image dimensions that break at other screen sizes or text scales |
| Add `Semantics(label: '...')` to meaningful images | Leave meaningful images without semantic labels |
| Use `Semantics(excludeSemantics: true)` for decorative images | Let decorative images pollute the accessibility tree |
| Verify `Hero` alignment holds at entry, exit, and all breakpoints | Ship shared-element transitions that misalign mid-animation |
