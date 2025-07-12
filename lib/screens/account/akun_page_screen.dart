import 'package:flutter/material.dart';
import 'setting_lokasi_screen.dart';
import 'setting_nomorhp_screen.dart';
import 'riwayat_transaksi_screen.dart';
import 'tukar_poin_screen.dart';
import 'edit_profil_screen.dart';
import 'umpan_balik_screen.dart';

class AkunPageScreen extends StatelessWidget {
  const AkunPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7748),
        title: const Text(
          'Akun Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Bagian Profil
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: const Color(0xFF1B7748),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Nama Pengguna',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'email@example.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // TODO: Navigasi ke edit profil
                      },
                      tooltip: 'Edit Profil',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Poin Daur Ulang
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: const Color(0xFFDEF5E7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.recycling, color: Color(0xFF1B7748), size: 28),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Poin Anda: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '1200',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B7748),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard, color: Color(0xFF1B7748)),
                      onPressed: () {
                        // TODO: Navigasi ke tukar poin
                      },
                      tooltip: 'Tukar Poin',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                _buildMenuItem(Icons.history, 'Riwayat Transaksi', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RiwayatTransaksiScreen()),
                  );
                }),
                _buildMenuItem(Icons.card_giftcard, 'Tukar Poin', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TukarPoinScreen()),
                  );
                }),
                _buildMenuItem(Icons.edit, 'Edit Profil', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfilScreen()),
                  );
                }),
                _buildMenuItem(Icons.location_on, 'Setting Lokasi', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingLokasiScreen()),
                  );
                }),
                _buildMenuItem(Icons.phone, 'Setting Nomor HP', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingNomorHPScreen()),
                  );
                }),
                _buildMenuItem(Icons.feedback, 'Umpan Balik', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UmpanBalikScreen()),
                  );
                }),
                _buildMenuItem(Icons.logout, 'Logout', isDestructive: true, onTap: () {
                  // TODO: Implementasi logout
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap ??
          () {
            // TODO: Tambahkan navigasi
          },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: isDestructive ? Colors.red : const Color(0xFF1B7748)),
          title: Text(
            title,
            style: TextStyle(
              color: isDestructive ? Colors.red : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
