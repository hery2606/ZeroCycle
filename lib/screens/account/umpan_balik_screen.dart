import 'package:flutter/material.dart';

class UmpanBalikScreen extends StatefulWidget {
  const UmpanBalikScreen({super.key});

  @override
  State<UmpanBalikScreen> createState() => _UmpanBalikScreenState();
}

class _UmpanBalikScreenState extends State<UmpanBalikScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Umpan Balik'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Berikan masukan atau saran Anda untuk aplikasi ini:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tulis umpan balik di sini...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B7748),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () {
                  // TODO: Kirim umpan balik
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Terima kasih atas umpan balik Anda!')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
