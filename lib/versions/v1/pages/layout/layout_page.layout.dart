import 'package:flutter/material.dart';

Widget _box(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
    width: 40,
    height: 40,
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Layout & Containers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Row — Main Axis Alignment
            Text('Row — Main Axis Alignment', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            ...[
              MainAxisAlignment.start,
              MainAxisAlignment.center,
              MainAxisAlignment.end,
              MainAxisAlignment.spaceBetween,
              MainAxisAlignment.spaceAround,
              MainAxisAlignment.spaceEvenly,
            ].expand((alignment) => [
              Text(
                '.${alignment.name}',
                style: textTheme.labelSmall!.copyWith(color: colorScheme.outline),
              ),
              const SizedBox(height: 4),
              Container(
                color: colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisAlignment: alignment,
                  children: [_box(context), _box(context), _box(context)],
                ),
              ),
              const SizedBox(height: 8),
            ]),
            const SizedBox(height: 16),
            // Section: Wrap Layout
            Text('Wrap Layout', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                12,
                (i) => Container(
                  width: 50 + i * 4.0,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: textTheme.labelSmall!.copyWith(color: colorScheme.onTertiaryContainer),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Section: Stack
            Text('Stack', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Chip(label: Text('Top left', style: textTheme.labelSmall)),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Chip(label: Text('Bottom right', style: textTheme.labelSmall)),
                  ),
                  Center(child: Text('Center', style: textTheme.titleSmall)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section: 8dp Spacing Grid
            Text('8dp Spacing Grid', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              children: [8, 16, 24, 32, 48].map((dp) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Container(width: dp.toDouble(), height: 32, color: colorScheme.primaryContainer),
                    const SizedBox(height: 4),
                    Text('${dp}dp', style: textTheme.labelSmall, textAlign: TextAlign.center),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
            // Section: Dividers
            Text('Dividers', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Text('Default Divider', style: textTheme.labelSmall!.copyWith(color: colorScheme.outline)),
            const Divider(),
            Text('Thick (2dp)', style: textTheme.labelSmall!.copyWith(color: colorScheme.outline)),
            Divider(thickness: 2, color: colorScheme.outline),
            Text('Indented (32dp)', style: textTheme.labelSmall!.copyWith(color: colorScheme.outline)),
            const Divider(indent: 32, endIndent: 32),
            SizedBox(
              height: 32,
              child: Row(
                children: [
                  const VerticalDivider(),
                  Expanded(
                    child: Center(
                      child: Text('VerticalDivider', style: textTheme.labelSmall),
                    ),
                  ),
                  const VerticalDivider(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section: Surface Elevation
            Text('Surface Elevation', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [0, 1, 2, 4, 8].map((e) => Card(
                elevation: e.toDouble(),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Center(child: Text('$e', style: textTheme.titleSmall)),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
