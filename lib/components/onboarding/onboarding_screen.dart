import 'package:flutter/material.dart';
import 'package:zerocycle/features/auth/login_screen.dart'; // Import halaman login

// Model konten onboarding
class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

// Daftar konten onboarding
final List<OnboardingContent> contents = [
  OnboardingContent(
    image: 'assets/images/gambar_1.png',
    title: 'Jual Sampah\nKe Bank Sampah',
    description:
        'Pilih Jenis Sampah, Isi Beratnya,\nJangan Lupa Jadwalkan\nPenjemputan Yaa..',
  ),
  OnboardingContent(
    image: 'assets/images/gambar_3.png',
    title: 'Peduli Bumi ?\nMulai Dari Sampahmu',
    description:
        'Mari Cintai Bumi yang Hijau, dengan\nMengelola Limbah Daur Ulang\nSecara Bertanggung Jawab',
  ),
  OnboardingContent(
    image: 'assets/images/gambar_2.png',
    title: 'Nikmati Cuan dari\nHasil Penukaran\nBarang Bekas',
    description:
        'Tukar Barang Bekasmu Jadi Cuan.\nUntuk Bumi yang Sehat, dan\nDompet yang Makin Happy',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color primaryColor = Color(0xFF27AE60);
  static const Color inactiveDotColor = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF333333);
  static const Color descriptionColor = Color(0xFF666666);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Tombol kembali
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: textColor),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: contents.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: descriptionColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Indikator titik
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Lanjut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == contents.length - 1) {
                      // Navigasi ke halaman login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Lanjut",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget indikator titik
  Container buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: _currentPage == index ? primaryColor : inactiveDotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
