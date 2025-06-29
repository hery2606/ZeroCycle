import 'package:flutter/material.dart';
import 'auth_header.dart';
import 'custom_text_field.dart';
import 'otpverificationscreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _visible = false;
  final TextEditingController _emailController = TextEditingController();

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
    _emailController.dispose();
    super.dispose();
  }

  void _sendOTP() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon masukkan email Anda')),
      );
      return;
    }
    
    // TODO: Implement actual OTP sending logic
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(email: _emailController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2ECC71),
      body: Column(
        children: [
          const AuthHeader(
            title: 'Lupa Password',
            subtitle: 'Reset password Anda',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Email Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2ECC71),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 25,
                              child: Container(
                                width: 30,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Lupa Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Kami akan mengirimkan password baru\nke email yang telah kamu daftarkan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        hintText: 'Email',
                        icon: Icons.alternate_email,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _sendOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Kirim Sekarang',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Kembali ke Login',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
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