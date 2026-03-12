import 'package:flutter/material.dart';

class StepperShowcasePage extends StatefulWidget {
  const StepperShowcasePage({super.key});
  @override
  State<StepperShowcasePage> createState() => _StepperShowcasePageState();
}

class _StepperShowcasePageState extends State<StepperShowcasePage> {
  int _vStep = 0;
  int _hStep = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Stepper')),
      // Stepper (both vertical and horizontal) uses Expanded+ListView internally,
      // so it MUST have a bounded-height parent. Never wrap Stepper in
      // SingleChildScrollView — use a Column body with Expanded instead.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Vertical Stepper', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
          ),
          Expanded(
            flex: 3,
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _vStep,
              onStepContinue: () {
                if (_vStep < 3) setState(() => _vStep++);
              },
              onStepCancel: () {
                if (_vStep > 0) setState(() => _vStep--);
              },
              steps: [
                Step(
                  title: const Text('Account'),
                  content: Text('Enter your email and password.', style: textTheme.bodyMedium),
                ),
                Step(
                  title: const Text('Profile'),
                  content: Text('Add your display name and avatar.', style: textTheme.bodyMedium),
                ),
                Step(
                  title: const Text('Preferences'),
                  content: Text('Choose your notification settings.', style: textTheme.bodyMedium),
                ),
                Step(
                  title: const Text('Confirm'),
                  content: Text('Review and submit your choices.', style: textTheme.bodyMedium),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Horizontal Stepper', style: textTheme.labelLarge!.copyWith(color: colorScheme.primary)),
          ),
          Expanded(
            flex: 2,
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _hStep,
              onStepContinue: () {
                if (_hStep < 2) setState(() => _hStep++);
              },
              onStepCancel: () {
                if (_hStep > 0) setState(() => _hStep--);
              },
              steps: const [
                Step(title: Text('Details'), content: SizedBox.shrink()),
                Step(title: Text('Payment'), content: SizedBox.shrink()),
                Step(title: Text('Review'), content: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
