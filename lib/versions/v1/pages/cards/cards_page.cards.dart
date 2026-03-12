import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Cards & Panels')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Card Variants
            Text('Card Variants', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elevated Card', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Default MD3 card with tonal surface elevation. Ideal for primary content groups.', style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filled Card', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Filled variant with surfaceContainerHighest background.', style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outlined Card', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Outlined variant with border and no elevation.', style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app_outlined, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('Tappable Card — tap me', style: textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Section: ListTile Variants
            Text('ListTile Variants', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: Text('Simple list tile', style: textTheme.titleSmall),
              subtitle: Text('Secondary description text', style: textTheme.bodySmall),
            ),
            ListTile(
              leading: const CircleAvatar(child: Text('AB')),
              title: Text('With avatar', style: textTheme.titleSmall),
              subtitle: Text('Shows leading avatar and trailing action', style: textTheme.bodySmall),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: 'More options',
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: Icon(Icons.star_outline, color: colorScheme.tertiary),
              title: Text('Three-line tile', style: textTheme.titleSmall),
              subtitle: Text(
                'This subtitle wraps onto two lines to demonstrate the three-line variant in action',
                style: textTheme.bodySmall,
              ),
              isThreeLine: true,
            ),
            const SizedBox(height: 24),
            // Section: ExpansionTile
            Text('ExpansionTile', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            for (int i = 1; i <= 3; i++)
              ExpansionTile(
                title: Text('Section $i', style: textTheme.titleSmall),
                leading: Icon(Icons.expand_circle_down_outlined, color: colorScheme.primary),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Expanded content for section $i. This area reveals additional detail when the tile is tapped.',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
