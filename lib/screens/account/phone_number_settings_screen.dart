import 'package:flutter/material.dart';

class PhoneNumberSettingsScreen extends StatefulWidget {
  const PhoneNumberSettingsScreen({super.key});

  @override
  State<PhoneNumberSettingsScreen> createState() => _PhoneNumberSettingsScreenState();
}

class _PhoneNumberSettingsScreenState extends State<PhoneNumberSettingsScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '+6281234567890');
  bool _isEditing = false;
  String _verificationCode = '';
  
  final List<String> _recentPhoneNumbers = [
    '+6281234567890',
    '+6289876543210',
    '+6287654321098',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _startVerification() {
    setState(() {
      _isEditing = true;
      // In a real app, this would send a verification code to the phone
      _verificationCode = '123456'; // Simulated code
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7748),
        title: const Text(
          'Nomor Telepon',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nomor Telepon Utama',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _isEditing
                        ? _buildVerificationForm()
                        : _buildPhoneDisplay(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Nomor Telepon Sebelumnya',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentPhoneNumbers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFDEF5E7),
                      child: Icon(Icons.phone, color: Color(0xFF1B7748)),
                    ),
                    title: Text(_recentPhoneNumbers[index]),
                    trailing: TextButton(
                      child: const Text(
                        'Gunakan',
                        style: TextStyle(color: Color(0xFF1B7748)),
                      ),
                      onPressed: () {
                        setState(() {
                          _phoneController.text = _recentPhoneNumbers[index];
                          _isEditing = false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Catatan: Nomor telepon digunakan untuk verifikasi dan notifikasi penting terkait aktivitas daur ulang Anda.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneDisplay() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Color(0xFF1B7748)),
                    const SizedBox(width: 12),
                    Text(
                      _phoneController.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDEF5E7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Terverifikasi',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1B7748),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B7748),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: _startVerification,
            child: const Text(
              'Ubah Nomor',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationForm() {
    return Column(
      children: [
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Nomor Telepon Baru',
            hintText: '+62...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: const Icon(Icons.phone, color: Color(0xFF1B7748)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            labelText: 'Kode Verifikasi',
            hintText: 'Masukkan 6 digit kode',
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1B7748)),
            suffixIcon: TextButton(
              onPressed: () {
                // Resend verification code
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kode verifikasi dikirim ulang')),
                );
              },
              child: const Text(
                'Kirim Ulang',
                style: TextStyle(color: Color(0xFF1B7748)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Color(0xFF1B7748)),
                ),
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    color: Color(0xFF1B7748),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B7748),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Verify and save the new number
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor telepon berhasil diperbarui')),
                  );
                  setState(() {
                    _isEditing = false;
                  });
                },
                child: const Text(
                  'Verifikasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
