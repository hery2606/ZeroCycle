import 'package:flutter/material.dart';

class PenukaranPage extends StatelessWidget {
  const PenukaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penukaran Poin'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Halaman Penukaran Poin.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
