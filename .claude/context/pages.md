# Page Specifications

10 social media app pages. All use `Theme.of(context).colorScheme.*` and `Theme.of(context).textTheme.*` — no hardcoded colors or font sizes. All padding/margins are multiples of 8dp.

> **Design iteration note:** Each version run should produce a **visually distinct layout** for the same 10 pages. Be creative — vary card styles, spacing density, typography hierarchy, component choices — while strictly following MD3 rules. The design should feel like a genuine alternative, not a copy.

---

## Page 1 — Splash (`SplashPage`)

**Role:** App entry screen. Full screen, no navigation chrome.

**Content:**
- Full-screen centered `Column`
- Large app icon placeholder: `Container` or `Icon`, 80×80dp, color `colorScheme.primary`
- App name: `displaySmall` text style
- Tagline text: `bodyLarge`, color `colorScheme.onSurfaceVariant`
- `LinearProgressIndicator` at bottom, 16dp horizontal padding
- Background: `colorScheme.surface`
- **No ThemeDropdown or VersionSwitcher on this page** (pre-auth screen)

---

## Page 2 — Login (`LoginPage` + `LoginFormWidget`)

**Role:** Authentication screen. No AppBar.

**LoginPage:** `Scaffold` with no AppBar. Centers `LoginFormWidget` with 24dp horizontal padding.

**LoginFormWidget content:**
- App icon + name at top (same as splash, smaller)
- `TextField` label "Email", `keyboardType: email`
- `SizedBox(height: 16)`
- `TextField` label "Password", `obscureText: true`
- `SizedBox(height: 24)`
- `FilledButton` "Sign In", full width
- `TextButton` "Forgot Password?"
- `Row` with `Expanded(Divider)` + padding Text "or" + `Expanded(Divider)`
- `OutlinedButton` "Create Account", full width
- Background: `colorScheme.surface`

---

## Page 3 — Home / Feed (`HomePage` + `FeedItemWidget`)

**Role:** Main feed. Primary nav destination.

**HomePage content:**
- `Scaffold` with `AppBar(title: Text(appName), actions: [IconButton(Icons.notifications_outlined)])`
- Body `Column`:
  - Horizontal `ListView` (height 88dp): 5 story circles (`CircleAvatar` 48dp + username `labelSmall` below), padding 8dp, spacing 8dp
  - `Divider`
  - `Expanded(ListView.builder)`: 8 `FeedItemWidget` items with mock data

**FeedItemWidget constructor:** `String username`, `String timeAgo`, `String postText`
- Elevated `Card`, margin 8dp horizontal + 4dp vertical
- `ListTile`: leading `CircleAvatar(radius: 20)`, title username in `titleSmall`, subtitle timeAgo in `bodySmall`
- Post text: `bodyMedium`, padding 16dp
- 16:9 `Container` image placeholder: color `colorScheme.surfaceVariant`, height 200dp
- Action row: 3 `TextButton.icon` (heart + count, chat + count, share icon), evenly spaced

---

## Page 4 — Profile (`ProfilePage` + `ProfileStatsWidget`)

**Role:** User profile. Primary nav destination.

**ProfilePage content:**
- `CustomScrollView` with `SliverAppBar(expandedHeight: 200, flexibleSpace: FlexibleSpaceBar(background: Container(color: colorScheme.surfaceVariant)))`, `actions: [IconButton(Icons.settings_outlined)]`
- `SliverToBoxAdapter` children:
  - Profile info `Row`: `CircleAvatar(radius: 32)` + `Column(displayName in titleLarge, username in bodyMedium, bio in bodySmall)`
  - `SizedBox(height: 16)` + `ProfileStatsWidget`
  - `Divider`
  - `SliverGrid` (crossAxisCount: 3, spacing: 2dp): 12 square `Container` placeholders, color `colorScheme.surfaceVariant`

**ProfileStatsWidget:** `Row` with 3 `Expanded` children, each a `Column(Text count titleLarge, Text label bodySmall)` for Posts / Followers / Following

---

## Page 5 — Notifications (`NotificationsPage` + `NotificationItemWidget`)

**Role:** Activity feed. Primary nav destination.

**NotificationsPage:** `Scaffold(AppBar("Notifications"), body: ListView.builder(12 items))`

**NotificationItemWidget constructor:** `String username`, `String action`, `String timeAgo`, `bool hasImage`
- `ListTile`:
  - leading: `CircleAvatar(radius: 20)`
  - title: `RichText` — username in `titleSmall` bold + ` $action` in `bodySmall`
  - subtitle: timeAgo in `bodySmall`, color `colorScheme.onSurfaceVariant`
  - trailing: if `hasImage`, 40×40dp square `Container(color: colorScheme.surfaceVariant)`

---

## Page 6 — Messages (`MessagesPage` + `MessageItemWidget`)

**Role:** Conversation list. Primary nav destination.

**MessagesPage:** `Scaffold(AppBar("Messages", actions: [IconButton(Icons.search)]), body: ListView.builder(10 items))`

**MessageItemWidget constructor:** `String username`, `String lastMessage`, `String timeAgo`, `int unreadCount`
- `ListTile`:
  - leading: `CircleAvatar(radius: 24)`
  - title: username in `titleSmall`
  - subtitle: lastMessage in `bodySmall`, maxLines 1, overflow ellipsis
  - trailing: `Column(crossAxisAlignment: end)` — timeAgo in `labelSmall` + (if unreadCount > 0) `Badge(label: Text('$unreadCount'))` with `colorScheme.primary`

---

## Page 7 — Explore (`ExplorePage` + `SearchBarWidget`)

**Role:** Search + discovery. Primary nav destination.

**ExplorePage content:**
- `Scaffold(AppBar("Explore"))`
- Body `Column`:
  - `SearchBarWidget` with 16dp padding
  - `Expanded(GridView.builder)`: crossAxisCount 3, spacing 2dp, 20 square `Container(color: colorScheme.surfaceVariant)` tiles

**SearchBarWidget:** M3 `SearchBar` widget, leading `Icon(Icons.search)`, hint "Search…", elevation 1, full width

---

## Page 8 — Create Post (`CreatePostPage` + `MediaPickerWidget`)

**Role:** New post composer. Accessible from Home via FAB.

**CreatePostPage content:**
- `Scaffold(AppBar("New Post", actions: [TextButton(child: Text("Share"), onPressed: () {})]))`
- Body `Column`:
  - `Expanded(MediaPickerWidget)`
  - `Padding(16dp)` around `TextField(label: "Write a caption…", maxLines: 4)`
  - `Row` of 3 `IconButton` actions (location, tag, music), spaced evenly, 8dp vertical padding

**MediaPickerWidget:** `Container(color: colorScheme.surfaceVariant)`, centered `Column`:
- `Icon(Icons.add_photo_alternate_outlined, size: 48, color: colorScheme.onSurfaceVariant)`
- `SizedBox(8)`
- `Text("Tap to add photo or video", style: bodyMedium)`

---

## Page 9 — Story (`StoryPage` + `StoryProgressWidget`)

**Role:** Full-screen story viewer. Accessible from Home story row.

**StoryPage content:**
- `Scaffold(extendBodyBehindAppBar: true, backgroundColor: colorScheme.surface)` — no AppBar
- `Stack` children:
  1. `Container(color: colorScheme.surfaceVariant)` — full screen background
  2. `StoryProgressWidget` (Positioned top, full width, padding 8dp from top)
  3. Bottom overlay `Positioned`: `Container` with gradient (`LinearGradient` from transparent to `colorScheme.scrim`), padding 16dp, `Row(CircleAvatar(radius: 18), Column(username titleSmall, timeAgo labelSmall), Spacer, IconButton(Icons.close, tooltip: "Close story"))`

**StoryProgressWidget constructor:** `int totalSegments`, `int activeSegment`
- `Row` of `totalSegments` items, each `Expanded(Container(height: 2dp, margin: EdgeInsets.symmetric(horizontal: 2)))`:
  - Past segments: `LinearProgressIndicator(value: 1.0, color: colorScheme.onSurface)`
  - Active segment: `LinearProgressIndicator(value: 0.6, color: colorScheme.onSurface)`
  - Future segments: `LinearProgressIndicator(value: 0.0, color: colorScheme.onSurfaceVariant)`

---

## Page 10 — Settings (`SettingsPage` + `SettingsItemWidget`)

**Role:** App settings. Accessible from Profile AppBar settings icon.

**SettingsPage:** `StatefulWidget` (needed for `SwitchListTile` state). `Scaffold(AppBar("Settings"))`.

Body `ListView` sections:

**Account section:**
- Section header: `Padding(16dp) Text("Account", style: labelLarge, color: colorScheme.primary)`
- `SettingsItemWidget("Edit Profile", Icons.person_outline)`
- `SettingsItemWidget("Change Password", Icons.lock_outline)`

**Notifications section:**
- `Divider`
- Section header: `Padding` Text "Notifications"
- `SwitchListTile(title: Text("Push Notifications"), value: _pushEnabled, onChanged: (v) => setState(() => _pushEnabled = v))`
- `SwitchListTile(title: Text("Email Notifications"), value: _emailEnabled, onChanged: ...)`

**More section:**
- `Divider`
- Section header: `Padding` Text "More"
- `SettingsItemWidget("Privacy", Icons.shield_outlined)`
- `SettingsItemWidget("Help", Icons.help_outline)`
- `SettingsItemWidget("About", Icons.info_outline)`
- `SizedBox(24)`
- `Padding(16dp)` → `FilledTonalButton("Log Out", onPressed: () {})`, full width

**SettingsItemWidget constructor:** `String label`, `IconData icon`
- `ListTile(leading: Icon(icon), title: Text(label, style: bodyLarge), trailing: Icon(Icons.chevron_right), onTap: () {})`

---

## Navigator — `VersionVNNavigator`

**Role:** Top-level navigator for a version. Lists all 10 pages in a `NavigationDrawer`.

- `StatefulWidget`, `_selectedIndex = 0`
- Uses a `Scaffold` with a `drawer:` containing `NavigationDrawer` listing all 10 pages
- On wide screens (≥ 1200dp via `LayoutBuilder`), drawer is persistent (always visible in a `Row`)
- AppBar actions: `[ThemeDropdown(), VersionSwitcher()]`
- Body: `IndexedStack` showing the page at `_selectedIndex`

**Drawer destinations (10 items):**
```dart
NavigationDrawerDestination(icon: Icon(Icons.home_outlined),           selectedIcon: Icon(Icons.home),                  label: Text('Home'))
NavigationDrawerDestination(icon: Icon(Icons.explore_outlined),        selectedIcon: Icon(Icons.explore),               label: Text('Explore'))
NavigationDrawerDestination(icon: Icon(Icons.chat_bubble_outline),     selectedIcon: Icon(Icons.chat_bubble),           label: Text('Messages'))
NavigationDrawerDestination(icon: Icon(Icons.notifications_outlined),  selectedIcon: Icon(Icons.notifications),         label: Text('Notifications'))
NavigationDrawerDestination(icon: Icon(Icons.person_outline),          selectedIcon: Icon(Icons.person),                label: Text('Profile'))
NavigationDrawerDestination(icon: Icon(Icons.auto_stories_outlined),   selectedIcon: Icon(Icons.auto_stories),          label: Text('Story'))
NavigationDrawerDestination(icon: Icon(Icons.add_box_outlined),        selectedIcon: Icon(Icons.add_box),               label: Text('Create Post'))
NavigationDrawerDestination(icon: Icon(Icons.settings_outlined),       selectedIcon: Icon(Icons.settings),              label: Text('Settings'))
NavigationDrawerDestination(icon: Icon(Icons.login_outlined),          selectedIcon: Icon(Icons.login),                 label: Text('Login'))
NavigationDrawerDestination(icon: Icon(Icons.start_outlined),          selectedIcon: Icon(Icons.start),                 label: Text('Splash'))
```

**Pages array (same order):**
`[HomePage(), ExplorePage(), MessagesPage(), NotificationsPage(), ProfilePage(), StoryPage(), CreatePostPage(), SettingsPage(), LoginPage(), SplashPage()]`
