# Class & Import Manifest

Replace `PACKAGE_NAME` with the actual Flutter package name (from `pubspec.yaml`'s `name:` field).
Replace `vN` with the current version number (e.g. `v1`, `v2`).

---

## Shared Classes (all versions)

| Class | File (relative to lib/) | Import |
|---|---|---|
| `App` | `app.dart` | `package:PACKAGE_NAME/app.dart` |
| `ThemeNames` | `themes/theme_names.dart` | `package:PACKAGE_NAME/themes/theme_names.dart` |
| `AppThemes` | `themes/app_themes.dart` | `package:PACKAGE_NAME/themes/app_themes.dart` |
| `ThemeProvider` | `providers/theme_provider.dart` | `package:PACKAGE_NAME/providers/theme_provider.dart` |
| `VersionProvider` | `providers/version_provider.dart` | `package:PACKAGE_NAME/providers/version_provider.dart` |
| `ThemeDropdown` | `widgets/theme_dropdown.dart` | `package:PACKAGE_NAME/widgets/theme_dropdown.dart` |
| `VersionSwitcher` | `widgets/version_switcher.dart` | `package:PACKAGE_NAME/widgets/version_switcher.dart` |
| `AdaptiveNavScaffold` | `widgets/adaptive_nav_scaffold.dart` | `package:PACKAGE_NAME/widgets/adaptive_nav_scaffold.dart` |
| `VersionConfig` | `versions/version_registry.dart` | `package:PACKAGE_NAME/versions/version_registry.dart` |
| `VersionRegistry` | `versions/version_registry.dart` | `package:PACKAGE_NAME/versions/version_registry.dart` |

---

## Version-Specific Classes (replace vN)

| Class | File path (under lib/) |
|---|---|
| `VersionVNNavigator` | `versions/vN/version_vN_navigator.dart` |
| `SplashPage` | `versions/vN/screens/splash/splash_page.splash.dart` |
| `LoginPage` | `versions/vN/screens/login/login_page.login.dart` |
| `LoginFormWidget` | `versions/vN/screens/login/login_form_widget.login.dart` |
| `HomePage` | `versions/vN/screens/home/home_page.home.dart` |
| `FeedItemWidget` | `versions/vN/screens/home/feed_item_widget.home.dart` |
| `ProfilePage` | `versions/vN/screens/profile/profile_page.profile.dart` |
| `ProfileStatsWidget` | `versions/vN/screens/profile/profile_stats_widget.profile.dart` |
| `NotificationsPage` | `versions/vN/screens/notifications/notifications_page.notifications.dart` |
| `NotificationItemWidget` | `versions/vN/screens/notifications/notification_item_widget.notifications.dart` |
| `MessagesPage` | `versions/vN/screens/messages/messages_page.messages.dart` |
| `MessageItemWidget` | `versions/vN/screens/messages/message_item_widget.messages.dart` |
| `ExplorePage` | `versions/vN/screens/explore/explore_page.explore.dart` |
| `SearchBarWidget` | `versions/vN/screens/explore/search_bar_widget.explore.dart` |
| `CreatePostPage` | `versions/vN/screens/create_post/create_post_page.create_post.dart` |
| `MediaPickerWidget` | `versions/vN/screens/create_post/media_picker_widget.create_post.dart` |
| `StoryPage` | `versions/vN/screens/story/story_page.story.dart` |
| `StoryProgressWidget` | `versions/vN/screens/story/story_progress_widget.story.dart` |
| `SettingsPage` | `versions/vN/screens/settings/settings_page.settings.dart` |
| `SettingsItemWidget` | `versions/vN/screens/settings/settings_item_widget.settings.dart` |

---

## Import Pattern for Version-Specific Files

```dart
import 'package:PACKAGE_NAME/versions/vN/screens/home/home_page.home.dart';
import 'package:PACKAGE_NAME/versions/vN/screens/profile/profile_page.profile.dart';
// ... etc. — follow the table above for every class
```

---

## version_registry.dart Structure

```dart
import 'package:flutter/widgets.dart';
import 'package:PACKAGE_NAME/versions/v1/version_v1_navigator.dart';
// add more version imports here as versions are created

class VersionConfig {
  final String label;
  final Widget Function() scaffold;
  const VersionConfig({required this.label, required this.scaffold});
}

class VersionRegistry {
  static final Map<int, VersionConfig> versions = {
    1: VersionConfig(label: 'V1', scaffold: () => const VersionV1Navigator()),
    // 2: VersionConfig(label: 'V2', scaffold: () => const VersionV2Navigator()),
  };
  static int get total => versions.length;
  static Widget getScaffold(int v) => versions[v]!.scaffold();
}
```

> Note: `VersionConfig` uses `final` for the map (not `const`) because `Widget Function()` is not a const expression.
