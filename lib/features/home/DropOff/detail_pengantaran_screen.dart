import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengantaranScreen extends StatefulWidget {
  final double weight;
  final List<String> selectedSubTypes;

  const DetailPengantaranScreen({
    super.key,
    required this.weight,
    required this.selectedSubTypes,
  });

  @override
  State<DetailPengantaranScreen> createState() => _DetailPengantaranScreenState();
}

class _DetailPengantaranScreenState extends State<DetailPengantaranScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  DateTime? selectedDate;
  String? selectedTime;

  final List<String> availableTimes = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'Drop Off',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Dapatkan bonus dari hasil penjualan sampahmu untuk jenis sampah tertentu.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Data Recycle-Giver',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'No. Ponsel: +62',
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        hintText: 'Tanggal Pengantaran',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      child: Text(
                        selectedDate != null
                            ? DateFormat('dd MMMM yyyy').format(selectedDate!)
                            : 'Tanggal Pengantaran',
                        style: TextStyle(
                          color: selectedDate != null ? Colors.black : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    hint: const Text('Waktu Pengantaran'),
                    value: selectedTime,
                    items: availableTimes.map((time) {
                      return DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Text(
                  'Informasi Tambahan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text(
                    'Opsional',
                    style: TextStyle(fontSize: 10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  backgroundColor: Color(0xFFE0E0E0),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Pesan',
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: const BorderSide(color: Color(0xFF0D723F)),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            final phone = phoneController.text.trim();
            final message = messageController.text.trim();

            if (selectedDate == null || selectedTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Silakan pilih tanggal dan waktu pengantaran')),
              );
              return;
            }

            if (phone.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mohon isi nomor ponsel')),
              );
              return;
            }

            if (widget.weight <= 0 || widget.selectedSubTypes.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data sampah belum lengkap')),
              );
              return;
            }

            Navigator.pushNamed(
              context,
              '/drop-off',
              arguments: {
                'phone': phone,
                'date': selectedDate!,
                'time': selectedTime!,
                'message': message,
                'weight': widget.weight,
                'selectedSubTypes': widget.selectedSubTypes,
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D723F),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Drop-Point Terdekat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
