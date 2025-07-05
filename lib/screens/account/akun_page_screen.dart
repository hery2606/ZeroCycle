import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/withdraw-page/WithdrawPage.dart';



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
          Container(
            color: const Color(0xFF1B7748),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nama Pengguna',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'email@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Poin Daur Ulang
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDEF5E7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.recycling, color: Color(0xFF1B7748), size: 32),
                SizedBox(width: 12),
                Text(
                  'Poin Anda: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '1200',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B7748),
                  ),
                ),
              ],
            ),
          ),

          // Menu & Setting
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(
                  context,
                  Icons.history,
                  'Riwayat Transaksi',
                  
                ),
                _buildMenuItem(
                  context,
                  Icons.card_giftcard,
                  'Tukar Poin',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WithdrawPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  Icons.edit,
                  'Edit Profil',
                  
                ),
                _buildMenuItem(
                  context,
                  Icons.feedback,
                  'Umpan Balik',
                
                ),
                _buildMenuItem(
                  context,
                  Icons.logout,
                  'Logout',
                  isDestructive: true,
                  onTap: () {
                    // Tambahkan logika logout di sini
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pengaturan Akun',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  Icons.location_on,
                  'Lokasi',
                 
                ),
                _buildMenuItem(
                  context,
                  Icons.phone,
                  'Nomor HP',
               
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return Container(
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
        onTap: onTap,
      ),
    );
  }
}
