# Dart/Flutter Pitfalls — Shared Rules

Include this block verbatim in every agent prompt.

---

**Dart/Flutter rules — strictly follow all of these:**

1. **No `context.watch`** — use `Consumer<T>` or `Selector<T,R>` for reactive UI; `context.read<T>()` only in callbacks.
2. **`const` constructors:** Only add `const` to a constructor call if every argument is also a compile-time constant. `const [ThemeDropdown(), VersionSwitcher()]` is valid because both widgets have `const` constructors. Never add `const` to a `Consumer`, `Builder`, or any widget that takes closures.
3. **No unused imports.** Only import what is actually referenced in the file.
4. **No hardcoded colors** (`Color(0xFF...)`) in widget trees — always `Theme.of(context).colorScheme.*`.
5. **No hardcoded font sizes** — always `Theme.of(context).textTheme.*`.
6. **Every `StatefulWidget` must have `createState()`** and its `State` class in the same file.
7. **`Navigator.pop(context)`** must only be called when a route can be popped. Always guard with `if (Navigator.canPop(context)) Navigator.pop(context)`.
8. **8dp spacing grid** — padding/margin values must be multiples of 8 (4dp only for micro-adjustments inside components).
9. **`@override`** on every overridden method (`build`, `createState`, `initState`, `dispose`).
10. **Semantic labels** on all icon-only buttons: `IconButton(tooltip: '...')`.
11. **`Stepper` requires bounded height** — Flutter's `Stepper` widget (both `StepperType.vertical` and `StepperType.horizontal`) uses `Expanded + ListView` internally. **Never** place a `Stepper` inside `SingleChildScrollView` — this causes a `RenderBox was not laid out` crash at runtime. Always give `Stepper` a bounded-height parent: use a `Column` body (not wrapped in `SingleChildScrollView`) and wrap each `Stepper` in `Expanded` (e.g. `Expanded(flex: 3, child: Stepper(...))`).
12. **`DropdownButtonFormField` uses `initialValue` not `value`** — the `value:` parameter was deprecated in Flutter 3.33+. Use `initialValue:` instead (e.g. `initialValue: _ddVal`). Note: `initialSelection:` is for `DropdownMenu`, not `DropdownButtonFormField`.
13. **`NavigationRail` preview requires explicit minimum height** — when showcasing `NavigationRail` inside a scrollable `Column`, always wrap the containing `Row` in a `SizedBox` with height ≥ `(72 × destinationCount) + 40`. For 3 destinations: minimum `SizedBox(height: 256)`. For 4 destinations: minimum `SizedBox(height: 328)`. Using `height: 200` with 3 labeled destinations (`NavigationRailLabelType.all`) causes "BOTTOM OVERFLOWED BY N PIXELS" because each destination renders icon (56dp) + label (~16dp) and Flutter does not scroll rail items.

14. **Horizontal edge alignment must be consistent across AppBar and page body — always 16dp** — the leading icon left edge, page body content left edge, and trailing action right edge must all land at 16dp from the screen edge on compact screens. This is the M3 content margin standard and must not be broken.

   - **Body content:** All page `SingleChildScrollView` / `CustomScrollView` must use `padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)`. Never use a different horizontal value (e.g. `24` or `8`) on one page while others use `16` — this creates a visible jump when navigating between pages.
   - **AppBar leading:** Flutter M3 automatically centers the `DrawerButton` / leading `IconButton` (24dp icon in 48dp touch target in 56dp slot) so the icon's left edge lands at 16dp. Do not override `leadingWidth` or add custom leading padding that would shift this.
   - **AppBar trailing:** `PopupMenuButton` with `child:` renders as a raw `InkWell` — Flutter does NOT add any automatic trailing padding (unlike `IconButton` which gets its own padding). The Row's trailing `SizedBox` must be `width: 16` to match the body's 16dp right margin.

   ```dart
   // ✅ Correct trailing — 16dp SizedBox aligns with body content right edge
   child: Row(
     mainAxisSize: MainAxisSize.min,
     children: [
       Text(_label(...)),
       const SizedBox(width: 4),
       const Icon(Icons.palette_outlined),
       const SizedBox(width: 16), // ← must be 16dp; no automatic padding is added
     ],
   )

   // ❌ Wrong — 8dp leaves the icon only 8dp from the right edge, misaligned with body
   // ❌ Wrong — 0dp clips the icon against the screen edge or status bar
   ```

15. **Never place `DropdownButton` in `AppBar(actions: [...])` — use `PopupMenuButton` instead** — `DropdownButton` in AppBar actions does not receive Flutter's automatic trailing-edge padding that `IconButton` and `PopupMenuButton` get. This causes the icon/widget to misalign or clip against the screen edge, especially on devices with rounded corners or notches. Always use `PopupMenuButton<T>` for icon-triggered menus in AppBars:

   ```dart
   // ✅ Correct — respects AppBar edge padding and 48×48dp touch target
   PopupMenuButton<ThemeNames>(
     icon: const Icon(Icons.palette_outlined),
     tooltip: 'Switch theme',
     onSelected: (t) => context.read<ThemeProvider>().setTheme(t),
     itemBuilder: (context) => ThemeNames.values
         .map((t) => PopupMenuItem<ThemeNames>(value: t, child: Text(_label(t))))
         .toList(),
   )

   // ❌ Wrong — icon bleeds outside AppBar safe zone, fails MD3 touch target spec
   // DropdownButton<ThemeNames>(icon: Icon(Icons.palette_outlined), underline: SizedBox.shrink(), ...)
   ```

15. **Error `SnackBar` must use `errorContainer`/`onErrorContainer` color roles** — never hardcode colors for error-state snackbars using `Colors.red`, `Colors.redAccent`, `Colors.red.shade800`, or any `Color(0xFF...)` literal. The bare `colorScheme.error` role is also wrong for a snackbar background — it is a full-saturation color that fails contrast at non-red seed themes. Always use `colorScheme.errorContainer` for the background, and `colorScheme.onErrorContainer` for both the content text color and `SnackBarAction.textColor`. These pairs are generated by `ColorScheme.fromSeed` and are guaranteed to meet WCAG AA contrast regardless of which theme seed is active.

   ```dart
   // ✅ Correct — adapts to every theme, guaranteed contrast
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       backgroundColor: Theme.of(context).colorScheme.errorContainer,
       content: Text(
         'Something went wrong',
         style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
       ),
       action: SnackBarAction(
         label: 'Retry',
         textColor: Theme.of(context).colorScheme.onErrorContainer,
         onPressed: () {},
       ),
     ),
   );

   // ❌ Wrong — hardcoded, ignores theme seed, breaks contrast on non-red themes
   // SnackBar(backgroundColor: Colors.red.shade800, ...)
   // SnackBar(backgroundColor: Colors.redAccent, ...)
   // SnackBar(backgroundColor: Color(0xFF8B0000), ...)
   // SnackBar(backgroundColor: Theme.of(context).colorScheme.error, ...)  ← also wrong
   ```
