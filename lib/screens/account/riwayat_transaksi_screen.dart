import 'package:flutter/material.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  const RiwayatTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, String>> transaksi = [
      {'tanggal': '2024-05-01', 'deskripsi': 'Daur ulang plastik', 'poin': '+100'},
      {'tanggal': '2024-04-28', 'deskripsi': 'Tukar poin', 'poin': '-200'},
      {'tanggal': '2024-04-20', 'deskripsi': 'Daur ulang kertas', 'poin': '+50'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transaksi.length,
        itemBuilder: (context, index) {
          final item = transaksi[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                item['poin']!.startsWith('+') ? Icons.add_circle : Icons.remove_circle,
                color: item['poin']!.startsWith('+') ? Colors.green : Colors.red,
              ),
              title: Text(item['deskripsi'] ?? ''),
              subtitle: Text(item['tanggal'] ?? ''),
              trailing: Text(
                item['poin'] ?? '',
                style: TextStyle(
                  color: item['poin']!.startsWith('+') ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
