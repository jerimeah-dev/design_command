# Naming Conventions & Coding Rules

## File Naming

| Item | Convention | Example |
|---|---|---|
| Feature folder | `snake_case` | `create_post/` |
| Screen file | `{className_snake}.{folderName}.dart` | `create_post_page.create_post.dart` |
| Widget in feature folder | `{className_snake}.{folderName}.dart` | `media_picker_widget.create_post.dart` |
| Shared widget (`lib/widgets/`) | `{className_snake}.dart` | `theme_dropdown.dart` |
| Class name | `PascalCase` | `CreatePostPage` |
| StatefulWidget + State | Both in the same file | 1 file for both classes |

---

## Provider Rules

- **Forbidden:** `context.watch<T>()` — never use this anywhere
- **Reactive UI:** `Consumer<T>(builder: (context, provider, child) => ...)` or `Selector<T, R>`
- **Event handlers only:** `context.read<T>().method()` — does not cause rebuilds
- Pages do NOT subscribe to `ThemeProvider`. They call `Theme.of(context)` which rebuilds automatically when `Consumer<ThemeProvider>` in `app.dart` rebuilds `MaterialApp`.

---

## State Management

- `provider` package only — no Riverpod, Bloc, GetX, or any other package
- `ThemeProvider extends ChangeNotifier` — holds `ThemeNames _currentTheme`
- `VersionProvider extends ChangeNotifier` — holds `int _current` and `final int total`
- Both registered in `MultiProvider` at the root (`app.dart`)

---

## Layout Rules

- **8dp spacing grid** — all padding and margins must be multiples of 8dp (use 4dp only for fine adjustments within components)
- No arbitrary values like 13dp, 22dp, 37dp — always 8, 16, 24, 32, 40, 48, 56, 64
- Touch targets: minimum 48×48dp for every interactive element
- Semantic labels on all icon-only buttons: `IconButton(tooltip: '...')` or `Semantics(label: '...')`
- Respect `MediaQuery.of(context).disableAnimations` before playing any animation

---

## Color & Typography Rules

- No hardcoded colors in widget trees — always `Theme.of(context).colorScheme.*`
- No hardcoded font sizes — always `Theme.of(context).textTheme.*`
- Theme system uses `ColorScheme.fromSeed()` — never manually assembled palettes
- Every surface color has an `onX` pair — `onPrimary` on `primary`, `onSurface` on `surface`, never mixed
