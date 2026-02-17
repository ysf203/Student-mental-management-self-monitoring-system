import 'package:flutter/material.dart';
import '../../models/checkin_entry.dart';
import '../checkin/checkin_screen.dart';
import '../insights/insights_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CheckInEntry> history = [];

  Future<void> _openCheckIn() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CheckInScreen()),
    );
    if (result == null) return;

    final entry = CheckInEntry(
      time: DateTime.now(),
      score: result['score'] as int,
      trigger: (result['trigger'] as String?) ?? '',
      note: (result['note'] as String?) ?? '',
    );

    setState(() => history.insert(0, entry));

    // Optional: if high stress, nudge breathing next (we’ll add this in the next step)
  }

  void _openInsights() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InsightsScreen(history: history),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final last = history.isEmpty ? null : history.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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
                    const Text("Today’s status",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(last == null ? "No check-ins yet" : "Last check-in: ${last.score}/10"),
                    if (last != null && last.trigger.isNotEmpty) Text("Trigger: ${last.trigger}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _openCheckIn,
                    child: const Text('Start check-in'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: history.isEmpty ? null : _openInsights,
                    child: const Text('Insights'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Recent check-ins",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: history.isEmpty
                  ? const Text("No data yet.")
                  : ListView.separated(
                      itemCount: history.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final e = history[i];
                        return Card(
                          child: ListTile(
                            title: Text("${e.score}/10"),
                            subtitle: Text(
                              e.trigger.isEmpty ? "No trigger" : e.trigger,
                            ),
                            trailing: Text(
                              "${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}",
                            ),
                          ),
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
