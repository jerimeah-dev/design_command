import 'package:flutter/widgets.dart';
import 'package:design_command/versions/v1/version_v1_navigator.dart';

class VersionConfig {
  final String label;
  final Widget Function() scaffold;
  const VersionConfig({required this.label, required this.scaffold});
}

class VersionRegistry {
  static final Map<int, VersionConfig> versions = {
    1: VersionConfig(label: 'V1', scaffold: () => const VersionV1Navigator()),
  };
  static int get total => versions.length;
  static Widget getScaffold(int v) => versions[v]!.scaffold();
}
