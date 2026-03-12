import 'package:flutter/material.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget styleRow(String name, TextStyle? style) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: textTheme.labelSmall!.copyWith(color: colorScheme.outline)),
        const SizedBox(height: 4),
        Text('The quick brown fox jumps', style: style!.copyWith(color: colorScheme.onSurface)),
        const SizedBox(height: 16),
      ],
    );

    Widget groupHeader(String label) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
        const Divider(height: 16),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Typography')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            groupHeader('DISPLAY'),
            styleRow('displayLarge', textTheme.displayLarge),
            styleRow('displayMedium', textTheme.displayMedium),
            styleRow('displaySmall', textTheme.displaySmall),
            const SizedBox(height: 24),
            groupHeader('HEADLINE'),
            styleRow('headlineLarge', textTheme.headlineLarge),
            styleRow('headlineMedium', textTheme.headlineMedium),
            styleRow('headlineSmall', textTheme.headlineSmall),
            const SizedBox(height: 24),
            groupHeader('TITLE'),
            styleRow('titleLarge', textTheme.titleLarge),
            styleRow('titleMedium', textTheme.titleMedium),
            styleRow('titleSmall', textTheme.titleSmall),
            const SizedBox(height: 24),
            groupHeader('BODY'),
            styleRow('bodyLarge', textTheme.bodyLarge),
            styleRow('bodyMedium', textTheme.bodyMedium),
            styleRow('bodySmall', textTheme.bodySmall),
            const SizedBox(height: 24),
            groupHeader('LABEL'),
            styleRow('labelLarge', textTheme.labelLarge),
            styleRow('labelMedium', textTheme.labelMedium),
            styleRow('labelSmall', textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
