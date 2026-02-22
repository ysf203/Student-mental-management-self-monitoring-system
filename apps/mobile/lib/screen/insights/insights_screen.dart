import 'package:flutter/material.dart';
import '../../models/checkin_entry.dart';

class InsightsScreen extends StatelessWidget {
  final List<CheckInEntry> history;

  const InsightsScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final avg = history.isEmpty
        ? 0
        : history.map((e) => e.score).reduce((a, b) => a + b) / history.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Summary",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text("Check-ins recorded: ${history.length}"),
                    Text("Average stress: ${avg.toStringAsFixed(1)}/10"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("History",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, i) {
                  final e = history[i];
                  return ListTile(
                    title: Text("${e.score}/10  •  ${e.trigger.isEmpty ? "No trigger" : e.trigger}"),
                    subtitle: e.note.isEmpty ? null : Text(e.note),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}