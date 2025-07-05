import 'package:flutter/material.dart';

class PencairanPage extends StatelessWidget {
  const PencairanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencairan Poin'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Form pencairan poin akan ditampilkan di sini.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
