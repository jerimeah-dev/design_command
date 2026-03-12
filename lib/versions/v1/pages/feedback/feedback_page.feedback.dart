import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Feedback & Alerts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Progress Indicators
            Text('Progress Indicators', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 8),
                    Text('Indeterminate', style: textTheme.labelSmall),
                  ],
                ),
                Column(
                  children: [
                    const CircularProgressIndicator(value: 0.7),
                    const SizedBox(height: 8),
                    Text('70%', style: textTheme.labelSmall),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(value: 1.0, color: colorScheme.secondary),
                    ),
                    const SizedBox(height: 8),
                    Text('100%', style: textTheme.labelSmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Indeterminate', style: textTheme.labelSmall),
            const SizedBox(height: 4),
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text('40%', style: textTheme.labelSmall),
            const SizedBox(height: 4),
            const LinearProgressIndicator(value: 0.4),
            const SizedBox(height: 24),
            // Section: Dialogs
            Text('Dialogs', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Discard changes?'),
                      content: Text('This action cannot be undone.', style: textTheme.bodyMedium),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                          },
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () {
                            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                          },
                          child: const Text('Discard'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Alert Dialog'),
                ),
                OutlinedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => SimpleDialog(
                      title: const Text('Choose size'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                          },
                          child: Text('Small', style: textTheme.bodyMedium),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                          },
                          child: Text('Medium', style: textTheme.bodyMedium),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                          },
                          child: Text('Large', style: textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Simple Dialog'),
                ),
                OutlinedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => Dialog.fullscreen(
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text('Full Screen'),
                          leading: CloseButton(
                            onPressed: () {
                              if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                            },
                          ),
                        ),
                        body: Center(
                          child: Text('Full-screen dialog content', style: textTheme.bodyLarge),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('Full-Screen Dialog'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: Bottom Sheet
            Text('Bottom Sheet', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                      height: 256,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text('Options', style: textTheme.titleMedium),
                          ),
                          const ListTile(leading: Icon(Icons.share_outlined), title: Text('Share')),
                          const ListTile(leading: Icon(Icons.link_outlined), title: Text('Copy link')),
                          const ListTile(leading: Icon(Icons.bookmark_outline), title: Text('Save')),
                        ],
                      ),
                    ),
                  ),
                  child: const Text('Modal Bottom Sheet'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: SnackBar
            Text('SnackBar', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Action completed successfully'),
                      action: SnackBarAction(label: 'Undo', onPressed: () {}),
                    ),
                  ),
                  child: const Text('Show SnackBar'),
                ),
                OutlinedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: colorScheme.errorContainer,
                      content: Text(
                        'Something went wrong',
                        style: TextStyle(color: colorScheme.onErrorContainer),
                      ),
                      action: SnackBarAction(
                        label: 'Retry',
                        textColor: colorScheme.onErrorContainer,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  child: const Text('Error SnackBar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: Tooltips
            Text('Tooltips', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Tooltip(message: 'Add to favorites', child: Icon(Icons.favorite_outline, color: colorScheme.primary)),
                const Tooltip(message: 'Share with others', child: Icon(Icons.share_outlined)),
                const Tooltip(message: 'Download file', child: Icon(Icons.download_outlined)),
                const Tooltip(message: 'Settings', child: Icon(Icons.settings_outlined)),
              ],
            ),
            const SizedBox(height: 8),
            const Tooltip(
              message: 'Chip tooltip — long-press to see',
              child: Chip(
                label: Text('Hover me'),
                avatar: Icon(Icons.info_outline, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
