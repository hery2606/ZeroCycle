import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/DropOff/detail_waste_screen.dart';

class DropOffScreen extends StatelessWidget {
  const DropOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Pengantaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Text(
              'Antarkan langsung sampahmu ke Drop Off Point terdekat. Lihat panduan berat sampah di sini.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Informasi Sampah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih jenis dan masukkan perkiraan berat sampah. Tidak ada batasan berat untuk minimal pengantaran.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildWasteOption(context, 'assets/images/kertas.png', 'Kertas'),
            _buildWasteOption(context, 'assets/images/botol.png', 'Plastik'),
            _buildWasteOption(context, 'assets/images/elektronik.png', 'Elektronik'),
            _buildWasteOption(context, 'assets/images/botolkaca.png', 'Botol Kaca'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteOption(BuildContext context, String iconPath, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 29, 28, 28).withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: const Color.fromARGB(255, 114, 114, 114),
            width: 3.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFFECECEC),
              shape: BoxShape.circle,
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailWasteScreen(
                    wasteType: label,
                    iconPath: iconPath,
                    subWasteTypes: _getSubWasteTypes(label),
                    estimatedPriceRange: _getEstimatedPriceRange(label),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D723F),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Pilih',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  // Helper untuk sub jenis sampah
  List<String> _getSubWasteTypes(String wasteType) {
    switch (wasteType) {
      case 'Kertas':
        return [
          'Koran',
          'Buku bekas',
          'Kertas Putih/HVS',
          'Kertas Warna/Duplek',
          'Kertas Buram',
          'Karton',
          'Kertas Lainnya',
        ];
      case 'Plastik':
        return [
          'Botol Plastik',
          'Plastik Kemasan',
          'Kantong Plastik',
          'Gelas Plastik',
          'Plastik Lainnya',
        ];
      case 'Elektronik':
        return [
          'Handphone Bekas',
          'Charger Rusak',
          'Earphone',
          'Perangkat Kecil Lainnya',
        ];
      case 'Botol Kaca':
        return [
          'Botol Minuman',
          'Toples Kaca',
          'Botol Kaca Pecah',
          'Kaca Lainnya',
        ];
      default:
        return [];
    }
  }

  // Helper untuk estimasi harga
  String _getEstimatedPriceRange(String wasteType) {
    switch (wasteType) {
      case 'Kertas':
        return 'Rp.500 sd Rp.1.500';
      case 'Plastik':
        return 'Rp.300 sd Rp.1.000';
      case 'Elektronik':
        return 'Rp.2.000 sd Rp.5.000';
      case 'Botol Kaca':
        return 'Rp.200 sd Rp.800';
      default:
        return 'Rp.0 sd Rp.0';
    }
  }
}
