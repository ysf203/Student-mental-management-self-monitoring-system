import 'package:flutter/material.dart';
import '../checkin/checkin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? lastScore;

  Future<void> _openCheckIn() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CheckInScreen()),
    );

    if (result == null) return;

    setState(() {
      lastScore = result['score'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lastScore == null ? "No check-ins yet" : "Last check-in: $lastScore/10",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _openCheckIn,
              child: const Text('Start check-in'),
            ),
          ],
        ),
      ),
    );
  }
}
