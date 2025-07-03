import 'package:flutter/material.dart';

class EmptyNotif extends StatelessWidget {
  const EmptyNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/emptynotif.png', // Pastikan file ini tersedia
              height: 180,
            ),
            const SizedBox(height: 24),
            const Text(
              'Tidak Ada Notifikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ayo, Jual Sampahmu Sekarang!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
