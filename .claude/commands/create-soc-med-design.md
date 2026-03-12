---
description: Generate a Flutter social media design showcase inside the current project. Produces 10 pages × 10 MD3 themes with versioning — each run creates a new design iteration (vN) without touching previous ones.
argument-hint: [--clean]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Agent
---

# create-soc-med-design

**Read this entire file before acting. Execute phases in order.**

---

## SHARED DART/FLUTTER RULES

Read `.claude/instructions/dart-pitfalls.md` now. Apply every rule in that file to all code generated in this session.

---

## PHASE 0 — ARGUMENT PARSING

Arguments received: `$ARGUMENTS`

### If `--clean` is present in `$ARGUMENTS`:

1. Warn the user:
   ```
   ⚠️  --clean flag detected.
   This will permanently delete the entire lib/ directory and regenerate everything from scratch.
   All versions, providers, themes, widgets, and screens will be removed.
   The project will be treated as a fresh first run (v1).
   ```
2. Ask: `Type YES to confirm, or anything else to cancel:`
   - Not `YES` (case-sensitive) → print `Cancelled. No changes made.` and **stop**.
3. Run via Bash: `rm -rf lib/ && mkdir lib`
4. Print: `🗑️  Deleted lib/ — starting from zero.`
5. Continue as a clean first run: EXISTING = 0, VERSION = 1.

### If `--clean` is NOT present: continue to Phase 1.

---

## PHASE 1 — PROJECT BOOTSTRAP

Read `.claude/instructions/bootstrap-templates.md` for the exact file contents to use below.

Use the Write tool to create each file **only if it does not already exist**:

| File | Skip if exists |
|---|---|
| `CLAUDE.md` (project root) | yes |
| `.claude/context/design_principles.md` | yes |
| `.claude/context/naming_and_rules.md` | yes |

Then verify these **required** project-specific context files exist (do NOT create them):
- `.claude/context/class_manifest.md`
- `.claude/context/themes.md`
- `.claude/context/pages.md`

If **any are missing** → print:
`⚠️ Missing required context file: .claude/context/{filename} — must be provided. Command cannot continue.`
Then **stop**.

---

## PHASE 2 — PREFLIGHT

1. **Read `pubspec.yaml`.**
   - Missing → stop: `"This is not a Flutter project. Run flutter create first."`
   - Extract `name:` → **PACKAGE_NAME**
   - No `provider:` in dependencies → warn: `"⚠️ provider not found — run: flutter pub add provider"`

2. **Count existing versions.**
   - Glob `lib/versions/v*/` → **EXISTING = count**, **VERSION = EXISTING + 1**
   - If VERSION > 1 → print: `"Found v1–v{EXISTING}. These will NOT be modified."`
   - Print: `"Generating v{VERSION} for package: {PACKAGE_NAME}"`

3. **Load context into memory** using the Read tool:
   - `.claude/context/design_principles.md`
   - `.claude/context/naming_and_rules.md`
   - `.claude/context/class_manifest.md`
   - `.claude/context/themes.md`
   - `.claude/context/pages.md`
   - `.claude/instructions/agent-instructions.md`

   From this point: `vN` = `v{VERSION}`, `VN` = `V{VERSION}`.

---

## PHASE 3 — PARALLEL GENERATION

Launch Agents A–F in a **single message** (all at once). Use `subagent_type: "general-purpose"`.

Every agent prompt must embed:
- Resolved PACKAGE_NAME and VERSION
- Full text of `naming_and_rules.md`, `class_manifest.md`, `design_principles.md`
- Relevant page specs from `pages.md`
- The **DART/FLUTTER PITFALLS** block (full text of `.claude/instructions/dart-pitfalls.md`)
- The agent's specific file list and instructions (from `.claude/instructions/agent-instructions.md`)

| Agent | Responsibility | Skip condition |
|---|---|---|
| A | Foundation: `main.dart`, `app.dart`, providers, themes | VERSION > 1 |
| B | Screens batch 1: splash, login, home | — |
| C | Screens batch 2: profile, notifications, messages | — |
| D | Screens batch 3: explore, create_post, story, settings | — |
| E | Shared widgets: `lib/widgets/` | VERSION > 1 |
| F | Version navigator: `lib/versions/vN/version_vN_navigator.dart` | — |

---

## PHASE 4 — INTEGRATION

Sequential — wait for all Phase 3 agents to complete.

Update `lib/versions/version_registry.dart`:

**First run (VERSION == 1) — create:**
```dart
import 'package:flutter/widgets.dart';
import 'package:{PACKAGE_NAME}/versions/v1/version_v1_navigator.dart';

class VersionConfig {
  final String label;
  final Widget Function() scaffold;
  const VersionConfig({required this.label, required this.scaffold});
}

class VersionRegistry {
  static final Map<int, VersionConfig> versions = {
    1: VersionConfig(label: 'V1', scaffold: () => const VersionV1Navigator()),
  };
  static int get total => versions.length;
  static Widget getScaffold(int v) => versions[v]!.scaffold();
}
```

**Re-run (VERSION > 1) — append only, never modify existing entries:**
- Add: `import 'package:{PACKAGE_NAME}/versions/vN/version_vN_navigator.dart';`
- Add map entry: `{VERSION}: VersionConfig(label: 'VN', scaffold: () => const VersionVNNavigator()),`

> `app.dart` does NOT need updating on re-runs — it reads `VersionRegistry.total` at runtime.

---

## PHASE 5 — QA DESIGN REVIEW

Sequential — wait for Phase 4 to complete.

Read `.claude/instructions/qa-instructions.md` for the full QA agent spec.

Launch a single QA agent (`subagent_type: "general-purpose"`). Embed in the prompt:
- PACKAGE_NAME and VERSION
- Full text of `design_principles.md` and `naming_and_rules.md`
- All newly generated file paths (Agents B, C, D, F — plus A, E on first run)
- The full QA instructions from `.claude/instructions/qa-instructions.md`

Print the QA Report when the agent returns.

---

## PHASE 6 — VALIDATE & FIX

Sequential — wait for Phase 5 to complete.

1. Run: `flutter analyze 2>&1`
2. Zero `error •` lines → proceed to Phase 7.
3. Errors found:
   - Parse each `error •` line: `error • <msg> • <file>:<line>:<col> • <rule>`
   - Read each errored file, fix with Edit (or Write for full rewrites), re-run analyze.
   - Repeat up to **3 iterations**.
4. Errors remain after 3 iterations → print:
   `⚠️ {N} error(s) remain after 3 fix passes. Manual review needed:` + error lines.

**Common fixes:**

| Error | Fix |
|---|---|
| `Undefined name 'Foo'` | Wrong import — check `class_manifest.md` for the correct `package:` path |
| `Non-constant expression in const context` | Remove `const` from that constructor call |
| `Required named parameter 'x' must be provided` | Add the missing argument |
| `The getter 'x' isn't defined` | Wrong `colorScheme`/`textTheme` property name |
| `Unused import` | Delete the import line |
| `Dead code` | Remove the unreachable statement |
| `A value of type 'X' can't be assigned to type 'Y'` | Fix the type mismatch |
| `Member 'x' can't be used as a setter` | Use the correct setter or state update approach |

---

## PHASE 7 — COMPLETION SUMMARY

```
✅ Done! Version v{VERSION} generated.

Package:        {PACKAGE_NAME}
Versions now:   {VERSION}
QA:             {N violations fixed}  (or: clean — no violations)
Analyze:        clean ✓  (or: N info/warning(s) — not blocking)

New files ({count}):
{list every file created in this run}

Next steps:
  flutter pub get
  flutter run

- Theme dropdown in every AppBar → switches all pages instantly
- Drawer → access all 10 pages
{if VERSION > 1: "- Version chips (V1–V{VERSION}) → compare design iterations"}
- Run this command again to generate v{VERSION+1}
```
