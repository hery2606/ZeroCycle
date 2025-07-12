import 'package:flutter/material.dart';

class SettingNomorHPScreen extends StatefulWidget {
  const SettingNomorHPScreen({super.key});

  @override
  State<SettingNomorHPScreen> createState() => _SettingNomorHPScreenState();
}

class _SettingNomorHPScreenState extends State<SettingNomorHPScreen> {
  final TextEditingController _nomorHPController = TextEditingController();

  @override
  void dispose() {
    _nomorHPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Nomor HP'),
        backgroundColor: const Color(0xFF1B7748),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDEF5E7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.phone, color: Color(0xFF1B7748), size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nomor HP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF1B7748),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _nomorHPController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nomor HP aktif',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save_alt),
                label: const Text('Simpan Nomor HP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B7748),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () {
                  // TODO: Simpan nomor HP
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor HP berhasil disimpan')),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
