import 'package:flutter/material.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});
  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  Set<String> _selected = {'Day'};

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Action Buttons
            Text('Action Buttons', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Elevated Button'))),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: () {}, child: const Text('Filled Button'))),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed: () {}, child: const Text('Tonal Button'))),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, child: const Text('Outlined Button'))),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: TextButton(onPressed: () {}, child: const Text('Text Button'))),
            const SizedBox(height: 24),
            // Section: Icon Buttons
            Text('Icon Buttons', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: const Icon(Icons.favorite_outline), tooltip: 'Standard icon button', onPressed: () {}),
                IconButton.filled(icon: const Icon(Icons.favorite), tooltip: 'Filled icon button', onPressed: () {}),
                IconButton.filledTonal(icon: const Icon(Icons.favorite_border), tooltip: 'Tonal icon button', onPressed: () {}),
                IconButton.outlined(icon: const Icon(Icons.favorite_border), tooltip: 'Outlined icon button', onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            // Section: FABs
            Text('Floating Action Buttons', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.small(onPressed: () {}, heroTag: 'fab-small', tooltip: 'Small FAB', child: const Icon(Icons.add)),
                FloatingActionButton(onPressed: () {}, heroTag: 'fab-std', tooltip: 'Standard FAB', child: const Icon(Icons.add)),
                FloatingActionButton.large(onPressed: () {}, heroTag: 'fab-large', tooltip: 'Large FAB', child: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {},
                heroTag: 'fab-ext',
                icon: const Icon(Icons.add),
                label: const Text('Create New'),
                tooltip: 'Extended FAB',
              ),
            ),
            const SizedBox(height: 24),
            // Section: Segmented Button
            Text('Segmented Button', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Day', label: Text('Day')),
                ButtonSegment(value: 'Week', label: Text('Week')),
                ButtonSegment(value: 'Month', label: Text('Month')),
              ],
              selected: _selected,
              onSelectionChanged: (s) => setState(() => _selected = s),
            ),
          ],
        ),
      ),
    );
  }
}
