import 'package:flutter/material.dart';
// 1. TAMBAHKAN IMPORT INI untuk menghubungkan ke halaman onboarding
import 'package:zerocycle/components/onboarding/onboarding_screen.dart'; // <-- Ganti 'zerocycle' dengan nama proyek Anda
// <-- Ganti 'package_name' dengan nama proyek Anda

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar untuk penyesuaian responsif
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Warna background hijau sesuai dengan gambar
      backgroundColor: const Color(0xFF1B7748),
      body: SafeArea(
        child: Padding(
          // Memberi padding di sisi kiri dan kanan
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer untuk mendorong konten ke tengah dan bawah
              const Spacer(flex: 2),

              // Logo Aplikasi
              Image.asset(
                // 2. PERBAIKAN: Spasi di akhir path telah dihapus
                'assets/images/logo_1.png', // Sebelumnya: 'assets/images/logo_1.png '
                height: screenHeight * 0.30, // Ukuran logo responsif
              ),
              SizedBox(height: screenHeight * 0.03),

              // Teks Nama Aplikasi
              const Text(
                'ZeroCycle',
                style: TextStyle(
                  fontFamily: 'Poppins', // Ganti dengan font pilihan Anda
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Teks Tagline
              const Text(
                'Ubah Sampahmu Jadi Cuan',
                style: TextStyle(
                  fontFamily: 'Poppins', // Ganti dengan font pilihan Anda
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              // Spacer untuk mendorong tombol ke bawah
              const Spacer(flex: 3),

              // Tombol Masuk
              SizedBox(
                width: double.infinity, // Tombol selebar layar
                child: ElevatedButton(
                  // 3. PERBAIKAN: Logika navigasi ditambahkan di sini
                  onPressed: () {
                    // Arahkan ke OnboardingScreen saat tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar tombol
                    foregroundColor: Colors.black, // Warna teks tombol
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Sudut tombol
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Spacer kecil di bagian bawah untuk memberi jarak dari tepi
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
