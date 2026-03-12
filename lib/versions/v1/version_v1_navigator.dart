import 'package:flutter/material.dart';
import 'package:design_command/versions/v1/pages/buttons/buttons_page.buttons.dart';
import 'package:design_command/versions/v1/pages/inputs/inputs_page.inputs.dart';
import 'package:design_command/versions/v1/pages/controls/controls_page.controls.dart';
import 'package:design_command/versions/v1/pages/navigation/navigation_showcase_page.navigation.dart';
import 'package:design_command/versions/v1/pages/stepper/stepper_showcase_page.stepper.dart';
import 'package:design_command/versions/v1/pages/cards/cards_page.cards.dart';
import 'package:design_command/versions/v1/pages/feedback/feedback_page.feedback.dart';
import 'package:design_command/versions/v1/pages/chips/chips_page.chips.dart';
import 'package:design_command/versions/v1/pages/lists/lists_page.lists.dart';
import 'package:design_command/versions/v1/pages/media/media_page.media.dart';
import 'package:design_command/versions/v1/pages/typography/typography_page.typography.dart';
import 'package:design_command/versions/v1/pages/layout/layout_page.layout.dart';
import 'package:design_command/widgets/theme_dropdown.dart';
import 'package:design_command/widgets/version_switcher.dart';

class VersionV1Navigator extends StatefulWidget {
  const VersionV1Navigator({super.key});

  @override
  State<VersionV1Navigator> createState() => _VersionV1NavigatorState();
}

class _VersionV1NavigatorState extends State<VersionV1Navigator> {
  int _selectedIndex = 0;

  void _onSelectNarrow(int index) {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() => _selectedIndex = index);
  }

  void _onSelectWide(int index) => setState(() => _selectedIndex = index);

  static const List<Widget> _pages = [
    ButtonsPage(),
    InputsPage(),
    ControlsPage(),
    NavigationShowcasePage(),
    StepperShowcasePage(),
    CardsPage(),
    FeedbackPage(),
    ChipsPage(),
    ListsPage(),
    MediaPage(),
    TypographyPage(),
    LayoutPage(),
  ];

  static const List<NavigationDrawerDestination> _destinations = [
    NavigationDrawerDestination(
      icon: Icon(Icons.smart_button_outlined),
      selectedIcon: Icon(Icons.smart_button),
      label: Text('Buttons'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.input_outlined),
      selectedIcon: Icon(Icons.input),
      label: Text('Inputs'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.tune_outlined),
      selectedIcon: Icon(Icons.tune),
      label: Text('Controls'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.navigation_outlined),
      selectedIcon: Icon(Icons.navigation),
      label: Text('Navigation'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.account_tree_outlined),
      selectedIcon: Icon(Icons.account_tree),
      label: Text('Stepper'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.credit_card_outlined),
      selectedIcon: Icon(Icons.credit_card),
      label: Text('Cards'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.feedback_outlined),
      selectedIcon: Icon(Icons.feedback),
      label: Text('Feedback'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.label_outline),
      selectedIcon: Icon(Icons.label),
      label: Text('Chips'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.list_alt_outlined),
      selectedIcon: Icon(Icons.list_alt),
      label: Text('Lists'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.perm_media_outlined),
      selectedIcon: Icon(Icons.perm_media),
      label: Text('Media'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.text_fields_outlined),
      selectedIcon: Icon(Icons.text_fields),
      label: Text('Typography'),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: Text('Layout'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Design Showcase v1'),
              actions: const [ThemeDropdown(), VersionSwitcher()],
            ),
            body: Row(
              children: [
                NavigationDrawer(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onSelectWide,
                  children: _destinations,
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Design Showcase v1'),
            actions: const [ThemeDropdown(), VersionSwitcher()],
          ),
          drawer: NavigationDrawer(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onSelectNarrow,
            children: _destinations,
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        );
      },
    );
  }
}
