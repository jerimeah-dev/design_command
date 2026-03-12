import 'package:flutter/material.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});
  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  bool _c1 = false;
  bool _c2 = true;
  bool? _c3;
  int _radio = 1;
  bool _s1 = true;
  bool _s2 = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Inputs & Forms')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Text Fields
            Text('Text Fields', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Standard', hintText: 'Type here…')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility_off_outlined),
                  tooltip: 'Toggle visibility',
                  onPressed: () {},
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Multiline notes',
                hintText: 'Write here…',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'With validation error',
                errorText: 'This field is required',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Disabled field', hintText: 'Not editable'),
              enabled: false,
            ),
            const SizedBox(height: 24),
            // Section: Checkboxes
            Text('Checkboxes', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Option A'),
              value: _c1,
              onChanged: (v) => setState(() => _c1 = v ?? false),
            ),
            CheckboxListTile(
              title: const Text('Option B'),
              value: _c2,
              onChanged: (v) => setState(() => _c2 = v ?? false),
            ),
            CheckboxListTile(
              title: const Text('Option C (tristate)'),
              value: _c3,
              onChanged: (v) => setState(() => _c3 = v),
              tristate: true,
            ),
            const SizedBox(height: 24),
            // Section: Radio Buttons
            Text('Radio Buttons', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            RadioGroup<int>(
              groupValue: _radio,
              onChanged: (v) => setState(() => _radio = v!),
              child: const Column(
                children: [
                  RadioListTile<int>(title: Text('Choice 1'), value: 1),
                  RadioListTile<int>(title: Text('Choice 2'), value: 2),
                  RadioListTile<int>(title: Text('Choice 3'), value: 3),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section: Switches
            Text('Switches', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Enable notifications'),
              subtitle: const Text('Receive push alerts'),
              value: _s1,
              onChanged: (v) => setState(() => _s1 = v),
            ),
            SwitchListTile(
              title: const Text('Auto-save drafts'),
              value: _s2,
              onChanged: (v) => setState(() => _s2 = v),
            ),
          ],
        ),
      ),
    );
  }
}
