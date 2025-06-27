import 'package:flutter/material.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bagian Poin (Kiri)
          Expanded(
            flex: 4, // Beri ruang lebih sedikit
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // PERBAIKAN: Menambahkan border abu-abu tipis
                  border: Border.all(color: Colors.grey[200]!, width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // PERBAIKAN: Menggunakan CircleAvatar untuk logo
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.transparent,
                        // Ganti dengan path logo cycle points Anda
                        child: Image.asset('assets/images/cycle.png'), 
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Cycle Points',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600, // Sedikit tebal
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bagian Aksi (Kanan)
          Expanded(
            flex: 5, // Beri ruang lebih banyak
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // PERBAIKAN: Memanggil _buildActionRow dengan path aset
                  _buildActionRow(
                      assetPath: 'assets/images/Vector.png', label: 'Bagikan'),
                  const SizedBox(height: 18),
                  _buildActionRow(
                      assetPath: 'assets/images/share.png', label: 'Penukaran'),
                  const SizedBox(height: 18),
                  _buildActionRow(
                      assetPath: 'assets/images/wallet.png', label: 'Pencairan'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PERBAIKAN: Method diubah untuk menerima path aset, bukan IconData
  Widget _buildActionRow({required String assetPath, required String label}) {
    return Row(
      children: [
        // Ikon kustom dalam lingkaran
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              assetPath,
              color: Colors.white, // Membuat ikon jadi putih
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}