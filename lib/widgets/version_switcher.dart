import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_command/providers/version_provider.dart';

class VersionSwitcher extends StatelessWidget {
  const VersionSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VersionProvider>(
      builder: (context, vp, child) {
        if (vp.total == 1) return const SizedBox.shrink();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(vp.total, (index) {
            final version = index + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text('V$version'),
                selected: vp.current == version,
                onSelected: (_) => context.read<VersionProvider>().setVersion(version),
              ),
            );
          }),
        );
      },
    );
  }
}
