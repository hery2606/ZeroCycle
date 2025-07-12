import 'package:flutter/material.dart';

class TukarPoinScreen extends StatelessWidget {
  const TukarPoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy rewards
    final rewards = [
      {'nama': 'Voucher Belanja', 'poin': 500},
      {'nama': 'Pulsa 10rb', 'poin': 1000},
      {'nama': 'Merchandise', 'poin': 1500},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tukar Poin'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: ListTile(
              leading: const Icon(Icons.card_giftcard, color: Color(0xFF1B7748)),
              title: Text(reward['nama'] as String),
              subtitle: Text('${reward['poin']} poin'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B7748),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berhasil menukar ${reward['nama']}')),
                  );
                },
                child: const Text('Tukar'),
              ),
            ),
          );
        },
      ),
    );
  }
}
