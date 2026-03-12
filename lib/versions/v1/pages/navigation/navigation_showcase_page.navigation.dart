import 'package:flutter/material.dart';

class NavigationShowcasePage extends StatefulWidget {
  const NavigationShowcasePage({super.key});
  @override
  State<NavigationShowcasePage> createState() => _NavigationShowcasePageState();
}

class _NavigationShowcasePageState extends State<NavigationShowcasePage> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Patterns')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: TabBar + TabBarView
            Text('TabBar + TabBarView', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: colorScheme.surface,
                    child: const TabBar(
                      tabs: [Tab(text: 'Feed'), Tab(text: 'Explore'), Tab(text: 'Profile')],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: TabBarView(
                      children: [
                        Center(child: Text('Feed content', style: textTheme.bodyMedium)),
                        Center(child: Text('Explore content', style: textTheme.bodyMedium)),
                        Center(child: Text('Profile content', style: textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section: NavigationRail preview
            Text('NavigationRail (preview)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: Card(
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _navIndex,
                      onDestinationSelected: (i) => setState(() => _navIndex = i),
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.explore_outlined),
                          selectedIcon: Icon(Icons.explore),
                          label: Text('Explore'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_outline),
                          selectedIcon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Center(
                        child: Text('Page $_navIndex', style: textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Section: NavigationBar preview
            Text('NavigationBar (preview)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text('NavigationBar', style: textTheme.labelLarge),
                  ),
                  NavigationBar(
                    selectedIndex: 0,
                    onDestinationSelected: (_) {},
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.explore_outlined),
                        selectedIcon: Icon(Icons.explore),
                        label: 'Explore',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.notifications_outlined),
                        selectedIcon: Icon(Icons.notifications),
                        label: 'Alerts',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section: SliverAppBar preview
            Text('SliverAppBar (preview)', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            Card(
              child: SizedBox(
                height: 180,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 120,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Flexible Title',
                          style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface),
                        ),
                        background: Container(color: colorScheme.surfaceContainerHighest),
                      ),
                      pinned: true,
                      automaticallyImplyLeading: false,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Content scrolls under the pinned AppBar.',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
