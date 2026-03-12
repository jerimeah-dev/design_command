import 'package:flutter/material.dart';
import 'package:design_command/widgets/theme_dropdown.dart';
import 'package:design_command/widgets/version_switcher.dart';

class AdaptiveNavScaffold extends StatefulWidget {
  const AdaptiveNavScaffold({
    super.key,
    required this.pages,
    required this.destinations,
    this.appBarTitle,
  });

  final List<Widget> pages;
  final List<NavigationDestination> destinations;
  final Widget? appBarTitle;

  @override
  State<AdaptiveNavScaffold> createState() => _AdaptiveNavScaffoldState();
}

class _AdaptiveNavScaffoldState extends State<AdaptiveNavScaffold> {
  int _selectedIndex = 0;

  void _onSelect(int i) => setState(() => _selectedIndex = i);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= 1200) {
          // Wide: persistent NavigationDrawer
          return Scaffold(
            appBar: AppBar(
              title: widget.appBarTitle,
              actions: const [ThemeDropdown(), VersionSwitcher()],
            ),
            body: Row(
              children: [
                NavigationDrawer(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onSelect,
                  children: widget.destinations
                      .asMap()
                      .entries
                      .map((e) => NavigationDrawerDestination(
                            icon: e.value.icon,
                            selectedIcon: e.value.selectedIcon,
                            label: Text(e.value.label),
                          ))
                      .toList(),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: widget.pages,
                  ),
                ),
              ],
            ),
          );
        } else if (width >= 600) {
          // Medium: NavigationRail
          return Scaffold(
            appBar: AppBar(
              title: widget.appBarTitle,
              actions: const [ThemeDropdown(), VersionSwitcher()],
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onSelect,
                  labelType: NavigationRailLabelType.all,
                  destinations: widget.destinations
                      .map((d) => NavigationRailDestination(
                            icon: d.icon,
                            selectedIcon: d.selectedIcon ?? d.icon,
                            label: Text(d.label),
                          ))
                      .toList(),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: widget.pages,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Compact: NavigationBar (bottom)
          return Scaffold(
            appBar: AppBar(
              title: widget.appBarTitle,
              actions: const [ThemeDropdown(), VersionSwitcher()],
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: widget.pages,
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onSelect,
              destinations: widget.destinations,
            ),
          );
        }
      },
    );
  }
}
