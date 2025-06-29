import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'auth_header.dart';
import 'reset_password_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  
  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  bool _visible = false;
  List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  int _seconds = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _visible = true;
      });
    });
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOTP() {
    if (_canResend) {
      // TODO: Implement resend OTP logic
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode OTP telah dikirim ulang')),
      );
    }
  }

  void _verifyOTP() {
    String otp = otpControllers.map((controller) => controller.text).join();
    
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon masukkan kode OTP lengkap')),
      );
      return;
    }
    
  // TODO: Implement actual OTP verification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(email: widget.email),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2ECC71),
      body: Column(
        children: [
          const AuthHeader(
            title: 'Verifikasi OTP',
            subtitle: 'Masukkan kode verifikasi',
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
                      // OTP Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.security,
                          color: Color(0xFF2ECC71),
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Verifikasi OTP',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Kode verifikasi telah dikirim ke\n${widget.email}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // OTP Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 60,
                            height: 60,
                            child: TextField(
                              controller: otpControllers[index],
                              focusNode: focusNodes[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFF2ECC71), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      // Timer and Resend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tidak menerima kode? ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          if (!_canResend)
                            Text(
                              'Kirim ulang dalam ${_seconds}s',
                              style: TextStyle(color: Colors.grey[600]),
                            )
                          else
                            GestureDetector(
                              onTap: _resendOTP,
                              child: const Text(
                                'Kirim Ulang',
                                style: TextStyle(
                                  color: Color(0xFF2ECC71),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _verifyOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF27AE60),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Verifikasi',
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
                          'Kembali',
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