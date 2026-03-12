---
description: Generate a Flutter design system showcase inside the current project. Produces 12 component pages × 10 MD3 themes with versioning — each run creates a new design iteration (vN) without touching previous ones. Generates a design_system_vN.md document per version.
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

Launch Agents A–G in a **single message** (all at once). Use `subagent_type: "general-purpose"`.

Every agent prompt must embed:
- Resolved PACKAGE_NAME and VERSION
- Full text of `naming_and_rules.md`, `class_manifest.md`, `design_principles.md`
- Relevant page specs from `pages.md`
- The **DART/FLUTTER PITFALLS** block (full text of `.claude/instructions/dart-pitfalls.md`)
- The agent's specific file list and instructions (from `.claude/instructions/agent-instructions.md`)

**⚠️ ISOLATION — embed in every screen agent prompt (B, C, D, E):**
> DO NOT read, glob, or inspect any files inside `lib/versions/` that belong to a previous version. Generate a completely fresh design for this version — different layout, different spacing rhythm, different section structure.

| Agent | Responsibility | Skip condition |
|---|---|---|
| A | Foundation: `main.dart`, `app.dart`, providers, themes | VERSION > 1 |
| B | Pages 1–3: Buttons, Inputs, Controls | — |
| C | Pages 4–6: Navigation showcase, Stepper, Cards | — |
| D | Pages 7–9: Feedback, Chips, Lists & Data | — |
| E | Pages 10–12: Media & Icons, Typography, Layout | — |
| F | Shared widgets: `lib/widgets/` | VERSION > 1 |
| G | Version navigator: `lib/versions/vN/version_vN_navigator.dart` | — |

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

## PHASE 5 — QA + DESIGN SYSTEM DOC

Sequential — wait for Phase 4 to complete. Then launch **two agents in parallel**:

### Agent QA
Read `.claude/instructions/qa-instructions.md` for the full QA agent spec.

Launch a single QA agent (`subagent_type: "general-purpose"`). Embed in the prompt:
- PACKAGE_NAME and VERSION
- Full text of `design_principles.md` and `naming_and_rules.md`
- All newly generated file paths (Agents B, C, D, E, G — plus A, F on first run)
- The full QA instructions from `.claude/instructions/qa-instructions.md`

### Agent DOC
Read `.claude/instructions/design-system-doc-agent.md` for the full spec.

Launch a design system doc agent (`subagent_type: "general-purpose"`). Embed in the prompt:
- PACKAGE_NAME and VERSION
- All 12 page file paths + navigator path for vN
- The full instructions from `.claude/instructions/design-system-doc-agent.md`

Wait for both agents to complete. Print the QA Report when it returns.

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
Pages:          12 design system component pages
QA:             {N violations fixed}  (or: clean — no violations)
Analyze:        clean ✓  (or: N info/warning(s) — not blocking)
Design doc:     lib/versions/v{VERSION}/design_system_v{VERSION}.md

New files ({count}):
{list every file created in this run}

Next steps:
  flutter pub get
  flutter run

- Theme dropdown in every AppBar → switches all 12 pages across 10 MD3 themes instantly
- NavigationDrawer → access all 12 component showcase pages
{if VERSION > 1: "- Version chips (V1–V{VERSION}) → compare design iterations side by side"}
- Run this command again to generate v{VERSION+1} with a fresh design approach
```
