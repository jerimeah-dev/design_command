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
