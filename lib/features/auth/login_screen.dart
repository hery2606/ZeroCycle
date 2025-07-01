import 'package:flutter/material.dart';
import 'auth_header.dart';
import 'custom_text_field.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'package:zerocycle/components/wrapper/main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visible = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2ECC71),
      body: Column(
        children: [
          const AuthHeader(
            title: 'Hello!',
            subtitle: 'Selamat Datang di ZeroCycle',
          ),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _visible ? 1.0 : 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Masuk',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),

                      // Email
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.alternate_email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Kata Sandi',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text('Lupa Kata Sandi?'),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tombol Lanjut
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          // Developer login bypass
                          if (email == 'admin' && password == 'password') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainWrapper()),
                            );
                            return;
                          }

                          // TODO: Tambahkan proses login normal di sini
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login gagal. Coba lagi.')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF27AE60),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Lanjut',
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Atau masuk dengan', style: TextStyle(color: Colors.grey[600])),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 24),

                      InkWell(
                        onTap: () {
                          // TODO: Login dengan Google
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Image.asset('assets/images/Google.png', height: 30),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Tidak punya akun? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                              );
                            },
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
