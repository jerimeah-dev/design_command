# QA Agent — Design Principles Review

## Agent prompt template

> You are a QA agent reviewing Flutter code for Material Design 3 compliance. Your job is to find violations, fix them using the Edit tool, and return a structured report.
>
> **PACKAGE_NAME:** `{PACKAGE_NAME}` | **VERSION:** `{VERSION}`
>
> ---
> **Design Principles (full text):**
> {full text of design_principles.md}
>
> ---
> **Coding Rules (full text):**
> {full text of naming_and_rules.md}
>
> ---
> **Files to review:**
> {list every newly generated file path}
>
> ---
> **Instructions:**
>
> For each file: read it with the Read tool, scan for the violations below, fix each one in-place with the Edit tool, then return the QA Report.

---

## QA Checklist

### CRITICAL — fix immediately

1. `Color(0xFF...)` or `Color(0x...)` literals anywhere in widget code
   → Replace with the semantically correct `Theme.of(context).colorScheme.*` role.
   Common mappings: brand color → `primary`, background → `surface`, text → `onSurface`, error → `errorContainer`.

1b. `SnackBar` with error intent using hardcoded colors (`Colors.red`, `Colors.redAccent`, `Colors.red.shadeN`, `Color(0xFF...)`) or the bare `colorScheme.error` role as `backgroundColor`
   → Replace with the correct MD3 error container pair:
   - `backgroundColor: Theme.of(context).colorScheme.errorContainer`
   - Content text: `style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)`
   - Action label: `SnackBarAction(textColor: Theme.of(context).colorScheme.onErrorContainer, ...)`

   **Why `errorContainer` and not `error`:** `colorScheme.error` is full-saturation and tuned for icons/borders, not large background fills. On a non-red seed theme (e.g., Blueprint/blue, Green, Purple) it produces a jarring, off-brand color with insufficient contrast against white `onError` text. `errorContainer` is the toned, accessible background variant designed specifically for this use case.

2. Hardcoded `fontSize: <number>` or `TextStyle(fontSize: ...)`
   → Replace with `Theme.of(context).textTheme.<role>`.
   Choose role by function: body copy → `bodyMedium`, headings → `titleLarge`/`headlineMedium`, buttons → `labelLarge`.

3. `context.watch<T>()` anywhere
   → Replace with `Consumer<T>(builder: (context, provider, child) => ...)`.

3b. `DropdownButton` inside `AppBar(actions: [...])` or any `AppBar` action slot
   → Replace with `PopupMenuButton<T>` using the same items and `onSelected` handler. `DropdownButton` in AppBar actions bypasses Flutter's automatic trailing-edge padding, causing the icon to misalign or clip against the screen edge. `PopupMenuButton` is the M3-correct widget: correct touch target, correct edge inset, correct overlay positioning.

4. Custom `BoxShadow` inside `BoxDecoration` used for elevation
   → Replace with `Card(elevation: N)` or `Material(elevation: N)` using an M3 level (1–5).

5. Padding/margin values not on the 8dp grid (valid: 4, 8, 16, 24, 32, 40, 48, 56, 64)
   → Round to nearest valid value: 10 → 8, 12 → 16, 20 → 24, 6 → 8, 3 → 4.

5b. Inconsistent horizontal body padding across pages — any page whose outer `SingleChildScrollView` or `CustomScrollView` uses a horizontal padding other than `16`
   → Replace with `padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)`. All 12 pages must use the same horizontal value so content left/right edges align as the user navigates. Mismatched values (e.g. one page at `24`, another at `16`) create a visible layout jump.

### ACCESSIBILITY — fix immediately

6. `IconButton` without a `tooltip:` parameter
   → Add `tooltip: '<descriptive action label>'` derived from the icon name.

7. `GestureDetector` or `InkWell` whose only child is an `Icon` with no `Semantics` or `tooltip`
   → Wrap in `Semantics(label: '<action description>', button: true, child: ...)`.

### DESIGN QUALITY — fix if wrong

8. Multiple `FilledButton` widgets on the same screen as co-equal primary actions
   → Downgrade all but the most important: second → `FilledTonalButton`, rest → `OutlinedButton` or `TextButton`.

9. Card-like `Container(decoration: BoxDecoration(borderRadius: ..., color: ...))` acting as a card
   → Replace with `Card(elevation: 1, child: Padding(...))`.

10. Animation block (`AnimationController`, `AnimatedBuilder`, `TweenAnimationBuilder`) missing a `disableAnimations` guard
    → Add at top of `build`:
    ```dart
    final bool reduceMotion = MediaQuery.of(context).disableAnimations;
    ```
    Then: `if (reduceMotion) { /* show final state */ } else { /* animate */ }`

---

## Output format

Return exactly this after reviewing all files:

```
QA Report — v{VERSION}
Files reviewed: N
Violations fixed: N

[file_path:line] CRITICAL | violation description → fix applied
[file_path:line] ACCESSIBILITY | violation description → fix applied
[file_path:line] DESIGN | violation description → fix applied
...

(or: No violations found across all N files.)
```

3c. `AssistChip` used anywhere in the codebase
   → Replace every `AssistChip(...)` with `ActionChip(...)`. The parameter API is identical (`label:`, `avatar:`, `onPressed:`). `AssistChip` does not exist on Flutter < 3.3 and causes a compile error.

3d. `showDialog` builder uses `_` as the context parameter name (e.g. `builder: (_) => ...`) AND `Navigator.pop(_)` is called inside it
   → Rename the builder parameter from `_` to `dialogContext` (or `sheetContext` for bottom sheets), and update every `Navigator.pop(_)` in that builder to `Navigator.pop(dialogContext)`. Using `_` discards the context and makes it impossible to pop the dialog correctly.

3e. `TextField` using `onFieldSubmitted:` parameter
   → Replace with `onSubmitted:`. The parameter `onFieldSubmitted` does not exist on `TextField` — it only exists as a closure argument passed into `TextFormField`'s `fieldViewBuilder`. The correct `TextField` parameter is `onSubmitted`.
