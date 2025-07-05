import 'package:flutter/material.dart';
import 'package:zerocycle/utils/animation_debugger.dart';

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
import 'package:zerocycle/screens/account/transaction_history_screen.dart';
import 'package:zerocycle/screens/account/edit_profile_screen.dart';
import 'package:zerocycle/screens/account/feedback_screen.dart';
import 'package:zerocycle/screens/account/location_settings_screen.dart';
import 'package:zerocycle/screens/account/phone_number_settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi debugger animasi
  AnimationDebugger.initialize();
  
  // Tambahkan ini untuk memperbaiki masalah animasi secara global
  FlutterError.onError = (FlutterErrorDetails details) {
    // Handle animasi error khusus
    if (details.exception.toString().contains('packages/flutter/lib/src/animation/curves.dart')) {
      debugPrint('Animation curve error detected and handled');
    } else {
      FlutterError.presentError(details);
    }
  };
  
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
        '/transaction-history': (context) => const TransactionHistoryScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        '/location-settings': (context) => const LocationSettingsScreen(),
        '/phone-settings': (context) => const PhoneNumberSettingsScreen(),
        

      
        
        
     
        // Anda bisa menambahkan rute lain di sini nanti, misal:
        // '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// Placeholder HomeScreen - replace with your actual home screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZeroCycle'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/drop-off');
          },
          child: const Text('Go to Drop Off'),
        ),
      ),
    );
  }
}
