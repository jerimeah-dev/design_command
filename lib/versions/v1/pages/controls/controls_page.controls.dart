import 'package:flutter/material.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage({super.key});
  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  double _vol = 50.0;
  RangeValues _range = const RangeValues(20, 80);
  int _step = 2;
  String _ddVal = 'Flutter';
  String _dmVal = 'Red';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Controls & Selection')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Sliders
            Text('Sliders', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Text('Volume: ${_vol.toInt()}', style: textTheme.bodyMedium),
            Slider(
              value: _vol,
              min: 0,
              max: 100,
              onChanged: (v) => setState(() => _vol = v),
            ),
            const SizedBox(height: 8),
            Text('Range: ${_range.start.toInt()}–${_range.end.toInt()}', style: textTheme.bodyMedium),
            RangeSlider(
              values: _range,
              min: 0,
              max: 100,
              onChanged: (v) => setState(() => _range = v),
            ),
            const SizedBox(height: 8),
            Text('Steps: $_step / 5', style: textTheme.bodyMedium),
            Slider(
              value: _step.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: '$_step',
              onChanged: (v) => setState(() => _step = v.toInt()),
            ),
            const SizedBox(height: 24),
            // Section: Dropdowns
            Text('Dropdowns', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Framework',
                border: OutlineInputBorder(),
              ),
              initialValue: _ddVal,
              items: ['Flutter', 'React Native', 'Xamarin', 'Ionic', 'Cordova']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _ddVal = v!),
            ),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              label: const Text('Accent color'),
              initialSelection: _dmVal,
              onSelected: (v) => setState(() => _dmVal = v ?? _dmVal),
              dropdownMenuEntries: ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange']
                  .map((s) => DropdownMenuEntry(value: s, label: s))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Section: Autocomplete
            Text('Autocomplete', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue tv) {
                if (tv.text.isEmpty) return const Iterable.empty();
                const options = [
                  'Argentina', 'Australia', 'Brazil', 'Canada', 'China',
                  'Denmark', 'Egypt', 'Finland', 'France', 'Germany',
                  'India', 'Italy', 'Japan', 'Kenya', 'Mexico',
                  'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden',
                ];
                return options.where(
                  (s) => s.toLowerCase().startsWith(tv.text.toLowerCase()),
                );
              },
              fieldViewBuilder: (ctx, ctrl, fn, onSubmit) => TextField(
                controller: ctrl,
                focusNode: fn,
                onSubmitted: (_) => onSubmit(),
                decoration: const InputDecoration(
                  labelText: 'Search country',
                  prefixIcon: Icon(Icons.search_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
