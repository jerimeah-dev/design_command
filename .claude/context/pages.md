# Page Specifications — Design System Showcase

12 component showcase pages covering the full Flutter/MD3 component inventory. All code uses `Theme.of(context).colorScheme.*` and `Theme.of(context).textTheme.*` — no hardcoded colors or font sizes. All padding/margins are multiples of 8dp.

> **Design iteration note:** Each version run must produce a **visually distinct design approach**. Vary layout density, section structure, card styling, typography hierarchy, spacing rhythm — while strictly following MD3 rules. The design must feel like a genuine alternative, not a reskin. **DO NOT read files from other version folders to generate this version.**

---

## Page 1 — Buttons (`ButtonsPage`)

**Role:** Showcase every Flutter/MD3 button variant with clear visual hierarchy.

**Widget type:** `StatefulWidget` (needs `_selected = <String>{'Day'}` for SegmentedButton)

**ButtonsPage:** `Scaffold(AppBar("Buttons"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header: `Text('Action Buttons', style: textTheme.labelLarge, color: colorScheme.primary)` + `SizedBox(height: 8)`
- `ElevatedButton('Elevated Button', onPressed: (){})` — `SizedBox(width: double.infinity)`
- `FilledButton('Filled Button', onPressed: (){})` — `SizedBox(width: double.infinity)`
- `FilledTonalButton('Tonal Button', onPressed: (){})` — `SizedBox(width: double.infinity)`
- `OutlinedButton('Outlined Button', onPressed: (){})` — `SizedBox(width: double.infinity)`
- `TextButton('Text Button', onPressed: (){})` — `SizedBox(width: double.infinity)`
- `SizedBox(height: 24)`
- Section header: `Text('Icon Buttons', style: textTheme.labelLarge, color: colorScheme.primary)` + `SizedBox(height: 8)`
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`:
  - `IconButton(icon: Icon(Icons.favorite_outline), tooltip: 'Standard icon button', onPressed: (){})`
  - `IconButton.filled(icon: Icon(Icons.favorite), tooltip: 'Filled icon button', onPressed: (){})`
  - `IconButton.filledTonal(icon: Icon(Icons.favorite_border), tooltip: 'Tonal icon button', onPressed: (){})`
  - `IconButton.outlined(icon: Icon(Icons.favorite_border), tooltip: 'Outlined icon button', onPressed: (){})`
- `SizedBox(height: 24)`
- Section header: `Text('Floating Action Buttons', ...)` + `SizedBox(height: 8)`
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`:
  - `FloatingActionButton.small(onPressed: (){}, heroTag: 'fab-small', child: Icon(Icons.add), tooltip: 'Small FAB')`
  - `FloatingActionButton(onPressed: (){}, heroTag: 'fab-std', child: Icon(Icons.add), tooltip: 'Standard FAB')`
  - `FloatingActionButton.large(onPressed: (){}, heroTag: 'fab-large', child: Icon(Icons.add), tooltip: 'Large FAB')`
- `SizedBox(height: 8)`
- `SizedBox(width: double.infinity, child: FloatingActionButton.extended(onPressed: (){}, heroTag: 'fab-ext', icon: Icon(Icons.add), label: Text('Create New'), tooltip: 'Extended FAB'))`
- `SizedBox(height: 24)`
- Section header: `Text('Segmented Button', ...)` + `SizedBox(height: 8)`
- `SegmentedButton<String>(segments: [ButtonSegment(value:'Day', label:Text('Day')), ButtonSegment(value:'Week', label:Text('Week')), ButtonSegment(value:'Month', label:Text('Month'))], selected: _selected, onSelectionChanged: (s) => setState(() => _selected = s))`

---

## Page 2 — Inputs (`InputsPage`)

**Role:** Text fields in all variants plus toggle form controls.

**Widget type:** `StatefulWidget` (needs: `_c1=false`, `_c2=true`, `_c3`, `_radio=1`, `_s1=true`, `_s2=false`)

**InputsPage:** `Scaffold(AppBar("Inputs & Forms"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Text Fields"
- `TextField(decoration: InputDecoration(labelText: 'Standard', hintText: 'Type here…'))`
- `SizedBox(height: 16)`
- `TextField(decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)), keyboardType: TextInputType.emailAddress)`
- `SizedBox(height: 16)`
- `TextField(decoration: InputDecoration(labelText: 'Password', suffixIcon: IconButton(icon: Icon(Icons.visibility_off_outlined), tooltip: 'Toggle visibility', onPressed: (){})), obscureText: true)`
- `SizedBox(height: 16)`
- `TextField(decoration: InputDecoration(labelText: 'Multiline notes', hintText: 'Write here…', alignLabelWithHint: true), maxLines: 3)`
- `SizedBox(height: 16)`
- `TextField(decoration: InputDecoration(labelText: 'With validation error', errorText: 'This field is required'))`
- `SizedBox(height: 16)`
- `TextField(decoration: InputDecoration(labelText: 'Disabled field', hintText: 'Not editable'), enabled: false)`
- `SizedBox(height: 24)`
- Section header "Checkboxes"
- `CheckboxListTile(title: Text('Option A'), value: _c1, onChanged: (v) => setState(() => _c1 = v ?? false))`
- `CheckboxListTile(title: Text('Option B'), value: _c2, onChanged: (v) => setState(() => _c2 = v ?? false))`
- `CheckboxListTile(title: Text('Option C (tristate)'), value: _c3, onChanged: (v) => setState(() => _c3 = v), tristate: true)`
- `SizedBox(height: 24)`
- Section header "Radio Buttons"
- `RadioListTile<int>(title: Text('Choice 1'), value: 1, groupValue: _radio, onChanged: (v) => setState(() => _radio = v!))`
- `RadioListTile<int>(title: Text('Choice 2'), value: 2, groupValue: _radio, onChanged: ...)`
- `RadioListTile<int>(title: Text('Choice 3'), value: 3, groupValue: _radio, onChanged: ...)`
- `SizedBox(height: 24)`
- Section header "Switches"
- `SwitchListTile(title: Text('Enable notifications'), subtitle: Text('Receive push alerts'), value: _s1, onChanged: (v) => setState(() => _s1 = v))`
- `SwitchListTile(title: Text('Auto-save drafts'), value: _s2, onChanged: (v) => setState(() => _s2 = v))`

---

## Page 3 — Controls (`ControlsPage`)

**Role:** Sliders, dropdowns, and autocomplete.

**Widget type:** `StatefulWidget` (needs: `_vol=50.0`, `_range=RangeValues(20,80)`, `_step=2`, `_ddVal='Flutter'`, `_dmVal='Red'`)

**ControlsPage:** `Scaffold(AppBar("Controls & Selection"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Sliders"
- `Text('Volume: \${_vol.toInt()}', style: textTheme.bodyMedium)`
- `Slider(value: _vol, min: 0, max: 100, onChanged: (v) => setState(() => _vol = v))`
- `SizedBox(height: 8)`
- `Text('Range: \${_range.start.toInt()}–\${_range.end.toInt()}', style: textTheme.bodyMedium)`
- `RangeSlider(values: _range, min: 0, max: 100, onChanged: (v) => setState(() => _range = v))`
- `SizedBox(height: 8)`
- `Text('Steps: \$_step / 5', style: textTheme.bodyMedium)`
- `Slider(value: _step.toDouble(), min: 0, max: 5, divisions: 5, label: '\$_step', onChanged: (v) => setState(() => _step = v.toInt()))`
- `SizedBox(height: 24)`
- Section header "Dropdowns"
- `DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Framework', border: OutlineInputBorder()), initialValue: _ddVal, items: ['Flutter','React Native','Xamarin','Ionic','Cordova'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => setState(() => _ddVal = v!))`
- `SizedBox(height: 16)`
- `DropdownMenu<String>(label: Text('Accent color'), initialSelection: _dmVal, onSelected: (v) => setState(() => _dmVal = v ?? _dmVal), dropdownMenuEntries: ['Red','Blue','Green','Yellow','Purple','Orange'].map((s) => DropdownMenuEntry(value: s, label: s)).toList())`
- `SizedBox(height: 24)`
- Section header "Autocomplete"
- `Autocomplete<String>(optionsBuilder: (TextEditingValue tv) { if (tv.text.isEmpty) return const Iterable.empty(); const options = ['Argentina','Australia','Brazil','Canada','China','Denmark','Egypt','Finland','France','Germany','India','Italy','Japan','Kenya','Mexico','Norway','Poland','Portugal','Spain','Sweden']; return options.where((s) => s.toLowerCase().startsWith(tv.text.toLowerCase())); }, fieldViewBuilder: (ctx, ctrl, fn, onSubmit) => TextField(controller: ctrl, focusNode: fn, onSubmitted: (_) => onSubmit(), decoration: InputDecoration(labelText: 'Search country', prefixIcon: Icon(Icons.search_outlined))))`

---

## Page 4 — Navigation (`NavigationShowcasePage`)

**Role:** Embedded TabBar, NavigationRail preview, NavigationBar preview, SliverAppBar demo.

**Widget type:** `StatefulWidget` (needs: `_navIndex = 0`)

**NavigationShowcasePage:** `Scaffold(AppBar("Navigation Patterns"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "TabBar + TabBarView"
- `DefaultTabController(length: 3, child: Column(mainAxisSize: MainAxisSize.min, children: [Material(color: colorScheme.surface, child: TabBar(tabs: [Tab(text:'Feed'), Tab(text:'Explore'), Tab(text:'Profile')])), SizedBox(height: 120, child: TabBarView(children: [Center(child:Text('Feed content', style:textTheme.bodyMedium)), Center(child:Text('Explore content', style:textTheme.bodyMedium)), Center(child:Text('Profile content', style:textTheme.bodyMedium))]))]))`
- `SizedBox(height: 24)`
- Section header "NavigationRail (preview)"
- `SizedBox(height: 200, child: Card(child: Row(children: [NavigationRail(selectedIndex: _navIndex, onDestinationSelected: (i) => setState(() => _navIndex = i), labelType: NavigationRailLabelType.all, destinations: [NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')), NavigationRailDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: Text('Explore')), NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile'))]), const VerticalDivider(width: 1), Expanded(child: Center(child: Text('Page \$_navIndex', style: textTheme.bodyLarge)))])))`
- `SizedBox(height: 24)`
- Section header "NavigationBar (preview)"
- `Card(child: Column(mainAxisSize: MainAxisSize.min, children: [Padding(padding: EdgeInsets.fromLTRB(16,16,16,8), child: Text('NavigationBar', style: textTheme.labelLarge)), NavigationBar(selectedIndex: 0, onDestinationSelected: (_){}, destinations: [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'), NavigationDestination(icon: Icon(Icons.notifications_outlined), selectedIcon: Icon(Icons.notifications), label: 'Alerts'), NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile')])]))`
- `SizedBox(height: 24)`
- Section header "SliverAppBar (preview)"
- `Card(child: SizedBox(height: 180, child: CustomScrollView(slivers: [SliverAppBar(expandedHeight: 120, flexibleSpace: FlexibleSpaceBar(title: Text('Flexible Title', style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface)), background: Container(color: colorScheme.surfaceContainerHighest)), pinned: true), SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(16), child: Text('Content scrolls under the pinned AppBar.', style: textTheme.bodyMedium)))])))`

---

## Page 5 — Stepper (`StepperShowcasePage`)

**Role:** Vertical and horizontal Stepper showcase.

**Widget type:** `StatefulWidget` (needs: `_vStep = 0`, `_hStep = 0`)

**⚠️ STEPPER LAYOUT RULE:** Flutter's `Stepper` widget (both vertical and horizontal) uses `Expanded + ListView` internally. It MUST have a bounded-height parent. **NEVER** place `Stepper` inside `SingleChildScrollView` — this causes a `RenderBox was not laid out` crash. Use a `Column` body and wrap each `Stepper` in `Expanded`.

**StepperShowcasePage:** `Scaffold(AppBar("Stepper"))`
Body: `Column(crossAxisAlignment: start)` — NO SingleChildScrollView:

- `Padding(fromLTRB(16,16,16,8))` + Section header "Vertical Stepper"
- `Expanded(flex: 3, child: Stepper(type: StepperType.vertical, currentStep: _vStep, onStepContinue: () { if (_vStep < 3) setState(() => _vStep++); }, onStepCancel: () { if (_vStep > 0) setState(() => _vStep--); }, steps: [Step(title: Text('Account'), content: Text('Enter your email and password.', style: textTheme.bodyMedium)), Step(title: Text('Profile'), content: Text('Add your display name and avatar.', style: textTheme.bodyMedium)), Step(title: Text('Preferences'), content: Text('Choose your notification settings.', style: textTheme.bodyMedium)), Step(title: Text('Confirm'), content: Text('Review and submit your choices.', style: textTheme.bodyMedium))]))`
- `Padding(fromLTRB(16,16,16,8))` + Section header "Horizontal Stepper"
- `Expanded(flex: 2, child: Stepper(type: StepperType.horizontal, currentStep: _hStep, onStepContinue: () { if (_hStep < 2) setState(() => _hStep++); }, onStepCancel: () { if (_hStep > 0) setState(() => _hStep--); }, steps: [Step(title: Text('Details'), content: SizedBox.shrink()), Step(title: Text('Payment'), content: SizedBox.shrink()), Step(title: Text('Review'), content: SizedBox.shrink())]))`

---

## Page 6 — Cards & Panels (`CardsPage`)

**Role:** Card variants, ListTile variants, ExpansionTile.

**Widget type:** `StatelessWidget`

**CardsPage:** `Scaffold(AppBar("Cards & Panels"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Card Variants"
- `Card(child: Padding(all: 16, child: Column(crossAxisAlignment: start, children: [Text('Elevated Card', style: textTheme.titleMedium), SizedBox(height: 8), Text('Default MD3 card with tonal surface elevation. Ideal for primary content groups.', style: textTheme.bodyMedium)])))` — default (elevated)
- `SizedBox(height: 8)`
- `Card(elevation: 0, color: colorScheme.surfaceContainerHighest, child: Padding(all: 16, child: Column(...same content, label 'Filled Card'...)))` — filled variant
- `SizedBox(height: 8)`
- `Card(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: colorScheme.outline)), child: Padding(all: 16, child: Column(...label 'Outlined Card'...)))` — outlined variant
- `SizedBox(height: 8)`
- `Card(child: InkWell(onTap: (){}, borderRadius: BorderRadius.circular(12), child: Padding(all: 16, child: Row(children: [Icon(Icons.touch_app_outlined, color: colorScheme.primary), SizedBox(width: 8), Text('Tappable Card — tap me', style: textTheme.titleSmall)]))))` — interactive card
- `SizedBox(height: 24)`
- Section header "ListTile Variants"
- `ListTile(leading: Icon(Icons.inbox_outlined), title: Text('Simple list tile', style: textTheme.titleSmall), subtitle: Text('Secondary description text', style: textTheme.bodySmall))`
- `ListTile(leading: CircleAvatar(child: Text('AB')), title: Text('With avatar', style: textTheme.titleSmall), subtitle: Text('Shows leading avatar and trailing action', style: textTheme.bodySmall), trailing: IconButton(icon: Icon(Icons.more_vert), tooltip: 'More options', onPressed: (){}))`
- `ListTile(leading: Icon(Icons.star_outline, color: colorScheme.tertiary), title: Text('Three-line tile', style: textTheme.titleSmall), subtitle: Text('This subtitle wraps onto two lines to demonstrate the three-line variant in action', style: textTheme.bodySmall), isThreeLine: true)`
- `SizedBox(height: 24)`
- Section header "ExpansionTile"
- For i in 1..3: `ExpansionTile(title: Text('Section \$i', style: textTheme.titleSmall), leading: Icon(Icons.expand_circle_down_outlined, color: colorScheme.primary), children: [Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 16), child: Text('Expanded content for section \$i. This area reveals additional detail when the tile is tapped.', style: textTheme.bodyMedium))])`

---

## Page 7 — Feedback (`FeedbackPage`)

**Role:** Progress indicators, dialogs, bottom sheets, snackbars, tooltips.

**Widget type:** `StatelessWidget` (dialog/sheet/snackbar triggered via builder context, no state needed)

**FeedbackPage:** `Scaffold(AppBar("Feedback & Alerts"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Progress Indicators"
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`:
  - `Column(children: [CircularProgressIndicator(), SizedBox(height: 8), Text('Indeterminate', style: textTheme.labelSmall)])`
  - `Column(children: [CircularProgressIndicator(value: 0.7), SizedBox(height: 8), Text('70%', style: textTheme.labelSmall)])`
  - `Column(children: [SizedBox(width: 40, height: 40, child: CircularProgressIndicator(value: 1.0, color: colorScheme.secondary)), SizedBox(height: 8), Text('100%', style: textTheme.labelSmall)])`
- `SizedBox(height: 16)`
- `Text('Indeterminate', style: textTheme.labelSmall)` + `SizedBox(height: 4)` + `LinearProgressIndicator()`
- `SizedBox(height: 8)`
- `Text('40%', style: textTheme.labelSmall)` + `SizedBox(height: 4)` + `LinearProgressIndicator(value: 0.4)`
- `SizedBox(height: 24)`
- Section header "Dialogs"
- `Wrap(spacing: 8, runSpacing: 8, children:`:
  - `OutlinedButton('Alert Dialog', onPressed: () => showDialog(context: context, builder: (dialogContext) => AlertDialog(title: Text('Discard changes?'), content: Text('This action cannot be undone.', style: textTheme.bodyMedium), actions: [TextButton('Cancel', onPressed: () => Navigator.pop(dialogContext)), FilledButton('Discard', onPressed: () => Navigator.pop(dialogContext))])))`
  - `OutlinedButton('Simple Dialog', onPressed: () => showDialog(context: context, builder: (dialogContext) => SimpleDialog(title: Text('Choose size'), children: [SimpleDialogOption(onPressed: () => Navigator.pop(dialogContext), child: Text('Small', style: textTheme.bodyMedium)), SimpleDialogOption(onPressed: () => Navigator.pop(dialogContext), child: Text('Medium', style: textTheme.bodyMedium)), SimpleDialogOption(onPressed: () => Navigator.pop(dialogContext), child: Text('Large', style: textTheme.bodyMedium))])))`
  - `OutlinedButton('Full-Screen Dialog', onPressed: () => showDialog(context: context, builder: (dialogContext) => Dialog.fullscreen(child: Scaffold(appBar: AppBar(title: Text('Full Screen'), leading: CloseButton(onPressed: () => Navigator.pop(dialogContext))), body: Center(child: Text('Full-screen dialog content', style: textTheme.bodyLarge))))))`
- `SizedBox(height: 24)`
- Section header "Bottom Sheet"
- `Wrap(spacing: 8, runSpacing: 8, children:`:
  - `OutlinedButton('Modal Bottom Sheet', onPressed: () => showModalBottomSheet(context: context, builder: (_) => SizedBox(height: 256, child: Column(children: [Padding(padding: EdgeInsets.all(16), child: Text('Options', style: textTheme.titleMedium)), ListTile(leading: Icon(Icons.share_outlined), title: Text('Share')), ListTile(leading: Icon(Icons.link_outlined), title: Text('Copy link')), ListTile(leading: Icon(Icons.bookmark_outline), title: Text('Save'))]))))`
- `SizedBox(height: 24)`
- Section header "SnackBar"
- `Wrap(spacing: 8, runSpacing: 8, children:`:
  - `OutlinedButton('Show SnackBar', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Action completed successfully'), action: SnackBarAction(label: 'Undo', onPressed: ()))))`
  - `OutlinedButton('Error SnackBar', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong'), backgroundColor: colorScheme.errorContainer, action: SnackBarAction(label: 'Retry', onPressed: ()))))`
- `SizedBox(height: 24)`
- Section header "Tooltips"
- `Wrap(spacing: 16, runSpacing: 8, children:`:
  - `Tooltip(message: 'Add to favorites', child: Icon(Icons.favorite_outline, color: colorScheme.primary))`
  - `Tooltip(message: 'Share with others', child: Icon(Icons.share_outlined))`
  - `Tooltip(message: 'Download file', child: Icon(Icons.download_outlined))`
  - `Tooltip(message: 'Settings', child: Icon(Icons.settings_outlined))`
- `SizedBox(height: 8)`
- `Tooltip(message: 'Chip tooltip — long-press to see', child: Chip(label: Text('Hover me'), avatar: Icon(Icons.info_outline, size: 16)))`

---

## Page 8 — Chips (`ChipsPage`)

**Role:** Every MD3 chip variant — display, input, choice, filter, action, assist.

**Widget type:** `StatefulWidget` (needs: `_choice='Medium'`, `_filters=<String>{}`, `_inputTags=['Design','Flutter','MD3','Dart','UI']`)

**ChipsPage:** `Scaffold(AppBar("Chips & Tags"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Chip (display)"
- `Wrap(spacing: 8, runSpacing: 8, children: [Chip(label: Text('Simple')), Chip(label: Text('With avatar'), avatar: CircleAvatar(child: Text('A'))), Chip(label: Text('Deletable'), onDeleted: (){}, deleteIcon: Icon(Icons.close, size: 16)), Chip(label: Text('With icon'), avatar: Icon(Icons.star_outline, size: 16))])`
- `SizedBox(height: 24)`
- Section header "InputChip (removable tags)"
- `Wrap(spacing: 8, runSpacing: 8, children: _inputTags.map((s) => InputChip(label: Text(s), onDeleted: () => setState(() => _inputTags.remove(s)))).toList())`
- `SizedBox(height: 24)`
- Section header "ChoiceChip (single select)"
- `Wrap(spacing: 8, runSpacing: 8, children: ['Small','Medium','Large','XL'].map((s) => ChoiceChip(label: Text(s), selected: _choice == s, onSelected: (_) => setState(() => _choice = s))).toList())`
- `SizedBox(height: 8)` + `Text('Selected: \$_choice', style: textTheme.bodySmall, color: colorScheme.onSurfaceVariant)`
- `SizedBox(height: 24)`
- Section header "FilterChip (multi-select)"
- `Wrap(spacing: 8, runSpacing: 8, children: ['Design','Code','Photo','Video','Music','Article'].map((s) => FilterChip(label: Text(s), selected: _filters.contains(s), onSelected: (v) => setState(() => v ? _filters.add(s) : _filters.remove(s)))).toList())`
- `SizedBox(height: 8)` + `Text('Selected: \${_filters.isEmpty ? 'none' : _filters.join(', ')}', style: textTheme.bodySmall, color: colorScheme.onSurfaceVariant)`
- `SizedBox(height: 24)`
- Section header "ActionChip"
- `Wrap(spacing: 8, runSpacing: 8, children: [ActionChip(label: Text('Share'), avatar: Icon(Icons.share_outlined, size: 16), onPressed: (){}), ActionChip(label: Text('Download'), avatar: Icon(Icons.download_outlined, size: 16), onPressed: (){}), ActionChip(label: Text('Bookmark'), avatar: Icon(Icons.bookmark_outline, size: 16), onPressed: (){}), ActionChip(label: Text('More'), onPressed: (){})])`
- `SizedBox(height: 24)`
- Section header "AssistChip"
- `Wrap(spacing: 8, runSpacing: 8, children: [ActionChip(label: Text('Add to calendar'), avatar: Icon(Icons.calendar_today_outlined, size: 16), onPressed: (){}), ActionChip(label: Text('Set reminder'), avatar: Icon(Icons.alarm_outlined, size: 16), onPressed: (){}), ActionChip(label: Text('Get directions'), avatar: Icon(Icons.directions_outlined, size: 16), onPressed: (){})])`

---

## Page 9 — Lists & Data (`ListsPage`)

**Role:** ListView, GridView, DataTable — three tabs.

**Widget type:** `StatelessWidget` (tabs are handled by DefaultTabController)

**ListsPage:** Uses `DefaultTabController(length: 3)` wrapping the scaffold.

```
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      title: Text('Lists & Data'),
      bottom: TabBar(tabs: [Tab(text:'List'), Tab(text:'Grid'), Tab(text:'Table')]),
    ),
    body: TabBarView(children: [_listTab, _gridTab, _tableTab]),
  ),
)
```

- **List tab**: `ListView.builder(itemCount: 15, itemBuilder: (_, i) => ListTile(leading: CircleAvatar(child: Text('\${i+1}')), title: Text('Item \${i+1}', style: textTheme.titleSmall), subtitle: Text('Subtitle for item \${i+1}', style: textTheme.bodySmall), trailing: Icon(Icons.chevron_right)))`
- **Grid tab**: `GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2), itemCount: 24, itemBuilder: (_, i) => Container(color: i.isEven ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainer, child: Center(child: Text('\${i+1}', style: textTheme.labelSmall))))`
- **Table tab**: `SingleChildScrollView(scrollDirection: Axis.horizontal, child: SingleChildScrollView(child: DataTable(columns: [DataColumn(label: Text('Name')), DataColumn(label: Text('Role')), DataColumn(label: Text('Dept')), DataColumn(label: Text('Status')), DataColumn(label: Text('Since'))], rows: [DataRow(cells: [DataCell(Text('Alice')), DataCell(Text('Designer')), DataCell(Text('UX')), DataCell(Text('Active')), DataCell(Text('2022'))]), DataRow(cells: [DataCell(Text('Bob')), DataCell(Text('Engineer')), DataCell(Text('Mobile')), DataCell(Text('Active')), DataCell(Text('2021'))]), DataRow(cells: [DataCell(Text('Carol')), DataCell(Text('PM')), DataCell(Text('Product')), DataCell(Text('Active')), DataCell(Text('2020'))]), DataRow(cells: [DataCell(Text('Dave')), DataCell(Text('Engineer')), DataCell(Text('Web')), DataCell(Text('Away')), DataCell(Text('2023'))]), DataRow(cells: [DataCell(Text('Eve')), DataCell(Text('Designer')), DataCell(Text('Brand')), DataCell(Text('Active')), DataCell(Text('2022'))]), DataRow(cells: [DataCell(Text('Frank')), DataCell(Text('QA')), DataCell(Text('Quality')), DataCell(Text('Active')), DataCell(Text('2021'))]), DataRow(cells: [DataCell(Text('Grace')), DataCell(Text('Lead')), DataCell(Text('Mobile')), DataCell(Text('Active')), DataCell(Text('2019'))]), DataRow(cells: [DataCell(Text('Hank')), DataCell(Text('DevOps')), DataCell(Text('Infra')), DataCell(Text('Away')), DataCell(Text('2020'))])])))`

---

## Page 10 — Media & Icons (`MediaPage`)

**Role:** CircleAvatars, clipped shapes, Hero animation, icon gallery, icon size scale.

**Widget type:** `StatelessWidget` (Hero detail is a private `_HeroDetailPage` class in the same file)

**Note:** `_HeroDetailPage` is a private `StatelessWidget` declared in the same file as `MediaPage`. It is acceptable to have private helper widgets in the same file.

**MediaPage:** `Scaffold(AppBar("Images & Media"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Circle Avatars (by size)"
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`: 5 × `CircleAvatar(radius: r, backgroundColor: colorScheme.primaryContainer, child: Text('AB', style: textTheme.labelSmall!.copyWith(color: colorScheme.onPrimaryContainer)))` for r in [16, 24, 32, 40, 56]
- `SizedBox(height: 16)`
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`: 3 × `CircleAvatar(radius: 32, backgroundColor: <primary/secondary/tertiaryContainer>, child: Icon(<icon>, color: <on-container>))`
- `SizedBox(height: 24)`
- Section header "Clipped Shapes"
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`:
  - `ClipRRect(borderRadius: BorderRadius.circular(12), child: Container(width: 80, height: 80, color: colorScheme.surfaceContainerHighest, child: Center(child: Icon(Icons.image_outlined, size: 32, color: colorScheme.outline))))`
  - `ClipOval(child: Container(width: 80, height: 80, color: colorScheme.secondaryContainer, child: Center(child: Icon(Icons.face_outlined, size: 32, color: colorScheme.onSecondaryContainer))))`
  - `ClipRRect(borderRadius: BorderRadius.circular(4), child: Container(width: 80, height: 80, color: colorScheme.tertiaryContainer, child: Center(child: Icon(Icons.landscape_outlined, size: 32, color: colorScheme.onTertiaryContainer))))`
- `SizedBox(height: 24)`
- Section header "Hero Animation"
- `GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _HeroDetailPage())), child: Hero(tag: 'media-hero-demo', child: Card(child: SizedBox(width: double.infinity, height: 120, child: Column(mainAxisAlignment: center, children: [Icon(Icons.open_in_full_outlined, color: colorScheme.primary, size: 32), SizedBox(height: 8), Text('Tap to expand (Hero transition)', style: textTheme.bodyMedium)])))))`
- `SizedBox(height: 24)`
- Section header "Icon Gallery"
- `Wrap(spacing: 16, runSpacing: 16)`: 20 `Icon` widgets — use a variety from `Icons` (home, search, star, settings, person, camera, edit, delete, share, download, favorite, notifications, mail, phone, location_on, lock, cloud, palette, music_note, image) all `size: 24, color: colorScheme.onSurface`
- `SizedBox(height: 24)`
- Section header "Icon Size Scale"
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround)`: `Icon(Icons.star_rounded, size: s, color: colorScheme.primary)` for s in [16, 24, 32, 48, 64]

**`_HeroDetailPage` (private class in same file):**
```dart
class _HeroDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CloseButton(), title: Text('Hero Expanded')),
      body: Center(
        child: Hero(
          tag: 'media-hero-demo',
          child: Card(
            margin: const EdgeInsets.all(32),
            child: SizedBox(
              width: double.infinity,
              height: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_in_full_outlined, size: 64),
                  SizedBox(height: 16),
                  Text('Hero detail view', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Page 11 — Typography (`TypographyPage`)

**Role:** All 15 MD3 text theme styles displayed with their names.

**Widget type:** `StatelessWidget`

**TypographyPage:** `Scaffold(AppBar("Typography"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

For each group, output a group label + `Divider(height: 16)` then rows per style:
- Each row: `Column(crossAxisAlignment: start, children: [Text('<styleName>', style: textTheme.labelSmall!.copyWith(color: colorScheme.outline)), SizedBox(height: 4), Text('The quick brown fox jumps', style: textTheme.<styleName>!.copyWith(color: colorScheme.onSurface)), SizedBox(height: 16)])`

**Groups:**
- **DISPLAY**: `displayLarge`, `displayMedium`, `displaySmall`
- **HEADLINE**: `headlineLarge`, `headlineMedium`, `headlineSmall`
- **TITLE**: `titleLarge`, `titleMedium`, `titleSmall`
- **BODY**: `bodyLarge`, `bodyMedium`, `bodySmall`
- **LABEL**: `labelLarge`, `labelMedium`, `labelSmall`

`SizedBox(height: 24)` between groups.

---

## Page 12 — Layout & Containers (`LayoutPage`)

**Role:** Row alignment, Wrap, Stack, spacing grid, dividers, surface elevation.

**Widget type:** `StatelessWidget`

**Helper:** `_Box` is a private const helper — `Container(width: 40, height: 40, decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(8)), margin: EdgeInsets.all(4))`

**LayoutPage:** `Scaffold(AppBar("Layout & Containers"))`
Body: `SingleChildScrollView` → `Padding(all: 16)` → `Column(crossAxisAlignment: start)`:

- Section header "Row — Main Axis Alignment"
- For each `MainAxisAlignment` in `[start, center, end, spaceBetween, spaceAround, spaceEvenly]`:
  - `Text('.\$alignment', style: textTheme.labelSmall, color: colorScheme.outline)` + `SizedBox(height: 4)`
  - `Container(color: colorScheme.surfaceContainerHighest, child: Row(mainAxisAlignment: ..., children: [_Box(ctx), _Box(ctx), _Box(ctx)]))` (pass context for colors)
  - `SizedBox(height: 8)`
- `SizedBox(height: 16)`
- Section header "Wrap Layout"
- `Wrap(spacing: 8, runSpacing: 8, children: List.generate(12, (i) => Container(width: 50 + i * 4.0, height: 40, decoration: BoxDecoration(color: colorScheme.tertiaryContainer, borderRadius: BorderRadius.circular(8)), child: Center(child: Text('\${i+1}', style: textTheme.labelSmall!.copyWith(color: colorScheme.onTertiaryContainer))))))`
- `SizedBox(height: 24)`
- Section header "Stack"
- `Container(height: 120, child: Stack(children: [Positioned.fill(child: Container(decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)))), Positioned(top: 8, left: 8, child: Chip(label: Text('Top left', style: textTheme.labelSmall))), Positioned(bottom: 8, right: 8, child: Chip(label: Text('Bottom right', style: textTheme.labelSmall))), Center(child: Text('Center', style: textTheme.titleSmall))]))`
- `SizedBox(height: 24)`
- Section header "8dp Spacing Grid"
- `Row(children: [for each dp in [8,16,24,32,48]: Column(children: [Container(width: dp.toDouble(), height: 32, color: colorScheme.primaryContainer), SizedBox(height: 4), Text('\${dp}dp', style: textTheme.labelSmall, textAlign: center)]), SizedBox(width: 8) between each])`
- `SizedBox(height: 24)`
- Section header "Dividers"
- `Text('Default Divider', style: textTheme.labelSmall, color: colorScheme.outline)` + `Divider()`
- `Text('Thick (2dp)', style: textTheme.labelSmall, color: colorScheme.outline)` + `Divider(thickness: 2, color: colorScheme.outline)`
- `Text('Indented (32dp)', style: textTheme.labelSmall, color: colorScheme.outline)` + `Divider(indent: 32, endIndent: 32)`
- `SizedBox(height: 32, child: Row(children: [VerticalDivider(), Expanded(child: Center(child: Text('VerticalDivider', style: textTheme.labelSmall))), VerticalDivider()]))`
- `SizedBox(height: 24)`
- Section header "Surface Elevation"
- `Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [for e in [0,1,2,4,8]: Card(elevation: e.toDouble(), child: SizedBox(width: 56, height: 56, child: Center(child: Text('\${e}', style: textTheme.titleSmall))))])`

---

## Navigator — `VersionVNNavigator`

**Role:** Top-level navigator for all 12 pages in a `NavigationDrawer`.

- `StatefulWidget`, `_selectedIndex = 0`
- Wide screens (≥ 1200dp via `LayoutBuilder`): persistent drawer in a `Row`
- Narrow (< 1200dp): `drawer:` in `Scaffold`
- AppBar title: `Text('Design Showcase vN')`
- AppBar actions: `const [ThemeDropdown(), VersionSwitcher()]`
- Body: `IndexedStack(index: _selectedIndex, children: _pages)`

**Drawer destinations (12 items):**
```dart
NavigationDrawerDestination(icon: Icon(Icons.smart_button_outlined),   selectedIcon: Icon(Icons.smart_button),   label: Text('Buttons'))
NavigationDrawerDestination(icon: Icon(Icons.input_outlined),           selectedIcon: Icon(Icons.input),           label: Text('Inputs'))
NavigationDrawerDestination(icon: Icon(Icons.tune_outlined),            selectedIcon: Icon(Icons.tune),            label: Text('Controls'))
NavigationDrawerDestination(icon: Icon(Icons.navigation_outlined),      selectedIcon: Icon(Icons.navigation),      label: Text('Navigation'))
NavigationDrawerDestination(icon: Icon(Icons.account_tree_outlined),    selectedIcon: Icon(Icons.account_tree),    label: Text('Stepper'))
NavigationDrawerDestination(icon: Icon(Icons.credit_card_outlined),     selectedIcon: Icon(Icons.credit_card),     label: Text('Cards'))
NavigationDrawerDestination(icon: Icon(Icons.feedback_outlined),        selectedIcon: Icon(Icons.feedback),        label: Text('Feedback'))
NavigationDrawerDestination(icon: Icon(Icons.label_outline),            selectedIcon: Icon(Icons.label),           label: Text('Chips'))
NavigationDrawerDestination(icon: Icon(Icons.list_alt_outlined),        selectedIcon: Icon(Icons.list_alt),        label: Text('Lists'))
NavigationDrawerDestination(icon: Icon(Icons.perm_media_outlined),      selectedIcon: Icon(Icons.perm_media),      label: Text('Media'))
NavigationDrawerDestination(icon: Icon(Icons.text_fields_outlined),     selectedIcon: Icon(Icons.text_fields),     label: Text('Typography'))
NavigationDrawerDestination(icon: Icon(Icons.dashboard_outlined),       selectedIcon: Icon(Icons.dashboard),       label: Text('Layout'))
```

**Pages array (same order as destinations):**
```dart
[ButtonsPage(), InputsPage(), ControlsPage(), NavigationShowcasePage(), StepperShowcasePage(), CardsPage(), FeedbackPage(), ChipsPage(), ListsPage(), MediaPage(), TypographyPage(), LayoutPage()]
```
