import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  double stress = 3;
  String? selectedTrigger;
  final noteController = TextEditingController();

  final triggers = const [
    'Study',
    'Sleep',
    'Social',
    'Money',
    'Health',
    'Other',
  ];

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(context, {
      'score': stress.round(),
      'trigger': selectedTrigger ?? '',
      'note': noteController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "How stressed do you feel right now?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "${stress.round()}/10",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    Slider(
                      value: stress,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: "${stress.round()}",
                      onChanged: (v) => setState(() => stress = v),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "What’s driving it? (optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: triggers.map((t) {
                final isSelected = selectedTrigger == t;
                return ChoiceChip(
                  label: Text(t),
                  selected: isSelected,
                  onSelected: (_) => setState(() {
                    selectedTrigger = isSelected ? null : t;
                  }),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Quick note (optional)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              child: const Text('Save check-in'),
            ),

            const SizedBox(height: 10),
            Text(
              "Note: This is a wellbeing self-monitoring tool, not medical advice.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
