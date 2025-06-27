import 'package:flutter/material.dart';

// Import semua halaman/layar yang akan kita gunakan
import 'package:zerocycle/features/onboarding/welcome_screen.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/features/onboarding/onboarding_screen.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/features/auth/login_screen.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/features/auth/register_screen.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/features/home/home_page.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/features/Loading/Loading_sreen.dart'; // <-- Ganti nama_proyek
import 'package:zerocycle/Screen/main_wrapper.dart'; // <-- Ganti nama_proyek

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zerocycle',
      theme: ThemeData(
        // Anda bisa mendefinisikan font default di sini
        fontFamily: 'Poppins', 
        primarySwatch: Colors.green,
        // Atur warna utama agar konsisten dengan tombol
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
          secondary: const Color(0xFF27AE60),
        ),
        // Atur style text button agar tidak berwarna biru default
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF27AE60), // Warna untuk "Lupa Kata Sandi?"
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      
      // initialRoute menentukan halaman mana yang pertama kali dibuka
      initialRoute: '/', 

      // routes mendefinisikan semua kemungkinan halaman dalam aplikasi
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/hom': (context) => const HomePage(),
        '/loading': (context) => const LoadingScreen(),
        '/home': (context) => const MainWrapper(),
        // Anda bisa menambahkan rute lain di sini nanti, misal:
        // '/home': (context) => const HomeScreen(),
      },
    );
  }
}