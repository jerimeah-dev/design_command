import 'package:flutter/material.dart';

class ChipsPage extends StatefulWidget {
  const ChipsPage({super.key});
  @override
  State<ChipsPage> createState() => _ChipsPageState();
}

class _ChipsPageState extends State<ChipsPage> {
  String _choice = 'Medium';
  final Set<String> _filters = {};
  final List<String> _inputTags = ['Design', 'Flutter', 'MD3', 'Dart', 'UI'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Chips & Tags')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Chip (display)
            Text('Chip (display)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Simple')),
                Chip(label: Text('With avatar'), avatar: CircleAvatar(child: Text('A'))),
                Chip(label: Text('With icon'), avatar: Icon(Icons.star_outline, size: 16)),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: const Text('Deletable'),
                  onDeleted: () {},
                  deleteIcon: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: InputChip (removable tags)
            Text('InputChip (removable tags)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _inputTags
                  .map((s) => InputChip(
                        label: Text(s),
                        onDeleted: () => setState(() => _inputTags.remove(s)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Section: ChoiceChip (single select)
            Text('ChoiceChip (single select)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Small', 'Medium', 'Large', 'XL']
                  .map((s) => ChoiceChip(
                        label: Text(s),
                        selected: _choice == s,
                        onSelected: (_) => setState(() => _choice = s),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: $_choice',
              style: textTheme.bodySmall!.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            // Section: FilterChip (multi-select)
            Text('FilterChip (multi-select)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Design', 'Code', 'Photo', 'Video', 'Music', 'Article']
                  .map((s) => FilterChip(
                        label: Text(s),
                        selected: _filters.contains(s),
                        onSelected: (v) => setState(() {
                          if (v) {
                            _filters.add(s);
                          } else {
                            _filters.remove(s);
                          }
                        }),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: ${_filters.isEmpty ? 'none' : _filters.join(', ')}',
              style: textTheme.bodySmall!.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            // Section: ActionChip
            Text('ActionChip', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  label: const Text('Share'),
                  avatar: const Icon(Icons.share_outlined, size: 16),
                  onPressed: () {},
                ),
                ActionChip(
                  label: const Text('Download'),
                  avatar: const Icon(Icons.download_outlined, size: 16),
                  onPressed: () {},
                ),
                ActionChip(
                  label: const Text('Bookmark'),
                  avatar: const Icon(Icons.bookmark_outline, size: 16),
                  onPressed: () {},
                ),
                ActionChip(
                  label: const Text('More'),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: AssistChip (rendered as ActionChip)
            Text('AssistChip', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  label: const Text('Add to calendar'),
                  avatar: const Icon(Icons.calendar_today_outlined, size: 16),
                  onPressed: () {},
                ),
                ActionChip(
                  label: const Text('Set reminder'),
                  avatar: const Icon(Icons.alarm_outlined, size: 16),
                  onPressed: () {},
                ),
                ActionChip(
                  label: const Text('Get directions'),
                  avatar: const Icon(Icons.directions_outlined, size: 16),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
