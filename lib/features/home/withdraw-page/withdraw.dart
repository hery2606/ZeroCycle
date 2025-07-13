import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/withdraw-page/WithdrawPage.dart';



class CyclePointWithdrawScreen extends StatelessWidget {
  final int currentBalance = 216000;

  const CyclePointWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Cycle Points',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Saldo tersedia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rp. ${currentBalance.toStringAsFixed(2).replaceAll('.00', '')}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (currentBalance <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saldo tidak mencukupi untuk pencairan')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WithdrawPage(),
                  ),
                );
                // TODO: Implementasikan aksi pencairan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D723F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Cairkan Komisi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Informasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'ZeroCycle hadir untuk mengubah sampah menjadi nilai nyata.\n'
              'Setiap 1 kilogram sampah yang kamu setorkan akan dikonversi menjadi 2 Cycle Points. '
              'Poin ini bisa kamu kumpulkan dan cairkan menjadi uang tunai.\n\n'
              'Proses pencairan dapat dilakukan melalui e-wallet seperti DANA atau langsung ke rekening bank yang terdaftar.\n'
              'Pastikan kamu telah menginstal aplikasi DANA terlebih dahulu agar proses pencairan komisi berjalan lancar.\n\n'
              'Dengan ZeroCycle, kamu tidak hanya membantu lingkungan, tapi juga meraih keuntungan secara nyata.\n'
              'Setor sampah, kumpulkan poin, dan nikmati cuannya!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
