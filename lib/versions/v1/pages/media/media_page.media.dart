import 'package:flutter/material.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Images & Media')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Circle Avatars (by size)
            Text('Circle Avatars (by size)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [16.0, 24.0, 32.0, 40.0, 56.0].map((r) => CircleAvatar(
                radius: r,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  'AB',
                  style: textTheme.labelSmall!.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.person_outlined, color: colorScheme.onPrimaryContainer),
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(Icons.favorite_outline, color: colorScheme.onSecondaryContainer),
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.tertiaryContainer,
                  child: Icon(Icons.star_outline, color: colorScheme.onTertiaryContainer),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: Clipped Shapes
            Text('Clipped Shapes', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(child: Icon(Icons.image_outlined, size: 32, color: colorScheme.outline)),
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 80,
                    height: 80,
                    color: colorScheme.secondaryContainer,
                    child: Center(child: Icon(Icons.face_outlined, size: 32, color: colorScheme.onSecondaryContainer)),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: colorScheme.tertiaryContainer,
                    child: Center(child: Icon(Icons.landscape_outlined, size: 32, color: colorScheme.onTertiaryContainer)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Section: Hero Animation
            Text('Hero Animation', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _HeroDetailPage()),
              ),
              child: Hero(
                tag: 'media-hero-demo',
                child: Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.open_in_full_outlined, color: colorScheme.primary, size: 32),
                        const SizedBox(height: 8),
                        Text('Tap to expand (Hero transition)', style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Section: Icon Gallery
            Text('Icon Gallery', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Icons.home, Icons.search, Icons.star, Icons.settings, Icons.person,
                Icons.camera_alt, Icons.edit, Icons.delete, Icons.share, Icons.download,
                Icons.favorite, Icons.notifications, Icons.mail, Icons.phone, Icons.location_on,
                Icons.lock, Icons.cloud, Icons.palette, Icons.music_note, Icons.image,
              ].map((icon) => Icon(icon, size: 24, color: colorScheme.onSurface)).toList(),
            ),
            const SizedBox(height: 24),
            // Section: Icon Size Scale
            Text('Icon Size Scale', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [16.0, 24.0, 32.0, 48.0, 64.0]
                  .map((s) => Icon(Icons.star_rounded, size: s, color: colorScheme.primary))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroDetailPage extends StatelessWidget {
  const _HeroDetailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text('Hero Expanded'),
      ),
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
                  const Icon(Icons.open_in_full_outlined, size: 64),
                  const SizedBox(height: 16),
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
