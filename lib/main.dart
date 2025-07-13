import 'package:flutter/material.dart';

// Import semua halaman/layar yang akan kita gunakan
import 'package:zerocycle/components/onboarding/welcome_screen.dart'; 
import 'package:zerocycle/components/onboarding/onboarding_screen.dart'; 
import 'package:zerocycle/features/auth/login_screen.dart'; 
import 'package:zerocycle/features/auth/register_screen.dart'; 
import 'package:zerocycle/features/home/home_page.dart'; 
import 'package:zerocycle/components/Loading/Loading_sreen.dart'; 
import 'package:zerocycle/components/wrapper/main_wrapper.dart'; 
import 'package:zerocycle/features/auth/OTPVerificationScreen.dart';
import 'package:zerocycle/features/auth/reset_password_screen.dart'; 
import 'package:zerocycle/features/auth/forgot_password_screen.dart'; 
import 'package:zerocycle/features/home/DropOff/drop_off_location_screen.dart';
import 'package:zerocycle/screens/points/bagikan_page.dart';


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
      initialRoute: '/home', // <-- Ganti dengan rute awal yang diinginkan
      // Gunakan onGenerateRoute untuk handle routing dengan parameter
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/detail-pengantaran':
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          
          case '/register':
            return MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            );
          
          case '/forgot-password':
            return MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            );
          
          case '/otp-verification':
            // Ambil email dari arguments
            final String email = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(email: email),
            );
          
          case '/reset-password':
            // Ambil email dari arguments
            final String email = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(email: email),
            );
          
          default:
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );

            
        }
      },

      

      // routes mendefinisikan semua kemungkinan halaman dalam aplikasi
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/hom': (context) => const HomePage(),
        '/loading': (context) => const LoadingScreen(),
        '/home': (context) => const MainWrapper(),
        '/otp': (context) => OTPVerificationScreen(email: ''),
        '/resetpw': (context) => const ResetPasswordScreen(),
        '/forgotPW': (context) => const ForgotPasswordScreen(),
        '/drop-off': (context) => const DropOffLocationScreen(),
        '/bagikan': (context) => const BagikanPage(),
        // Tambahkan rute lain sesuai kebutuhan
        

      
        
        
     
        // Anda bisa menambahkan rute lain di sini nanti, misal:
        // '/home': (context) => const HomeScreen(),
      },
    );
  }
}
