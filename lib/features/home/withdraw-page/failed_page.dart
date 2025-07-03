import 'package:flutter/material.dart';

class WithdrawFailedPage extends StatelessWidget {
  const WithdrawFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Icon Gagal
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFCE8E6),
                ),
                padding: const EdgeInsets.all(30),
                child: const Icon(
                  Icons.close,
                  color: Color(0xFFD32F2F), // merah
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Penarikan komisi gagal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan coba lagi nanti atau hubungi CS',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            const Divider(),

            // Info Detail Penarikan (sama dengan versi sukses)
            _InfoTile(title: 'Jumlah penarikan komisi', value: 'Rp. 216.000.00'),
            _InfoTile(title: 'Biaya layanan', value: 'Rp. 907'),
            _InfoTile(
              title: 'Transfer ke',
              value: 'DANA\n(62-********1221)',
            ),
            _InfoTile(title: 'ID Pesanan', value: '****************'),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
