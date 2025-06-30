import 'package:flutter/material.dart';

class BagikanPage extends StatelessWidget {
  const BagikanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bagikan Poin'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Fitur Bagikan Poin belum tersedia.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
