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

class _DetailPengantaranScreenState extends State<DetailPengantaranScreen> with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  DateTime? selectedDate;
  String? selectedTime;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;

  final List<String> availableTimes = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
  ];

  // Sample previously used phone numbers
  final List<String> recentPhoneNumbers = [
    '+6281234567890',
    '+6289876543210',
    '+6287654321098',
  ];
  
  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _buttonAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    phoneController.dispose();
    messageController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  Widget _buildPhoneOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: 'Ambil nomor dari $label', // Added tooltip
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF0D723F).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: const Color(0xFF0D723F)),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Get phone number from user profile
  void _getPhoneFromProfile() {
    // TODO: Implement actual integration with user profile
    setState(() {
      phoneController.text = '+628123456789'; // Placeholder value
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nomor telepon diambil dari profil')),
    );
  }

  // Get phone number from contacts
  Future<void> _getPhoneFromContacts() async {
    // TODO: Implement actual contact picker integration
    // This would typically use a contact picker plugin
    setState(() {
      phoneController.text = '+628987654321'; // Placeholder value
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nomor telepon diambil dari kontak')),
    );
  }

  // Get phone number from previously used numbers
  void _getPhoneFromHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF0D723F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: const [
                Icon(Icons.history, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Nomor Telepon Terakhir Digunakan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // List of phone numbers with better tap indication
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recentPhoneNumbers.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        phoneController.text = recentPhoneNumbers[index];
                      });
                      Navigator.pop(context);
                      // Show confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nomor telepon ${recentPhoneNumbers[index]} dipilih'),
                          backgroundColor: const Color(0xFF0D723F),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, color: Color(0xFF0D723F)),
                          const SizedBox(width: 16),
                          Text(
                            recentPhoneNumbers[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(Icons.touch_app, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          const Text(
                            'Tekan untuk pilih',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      // Theme customization for better visibility
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0D723F),
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0D723F),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tanggal ${DateFormat('dd MMMM yyyy').format(picked)} dipilih'),
          backgroundColor: const Color(0xFF0D723F),
        ),
      );
    }
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
          Tooltip(
            message: 'Info pengantaran',
            child: IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Info Pengantaran'),
                    content: const Text(
                      'Isi form ini untuk menjadwalkan pengantaran sampah daur ulang Anda ke lokasi drop-off.'
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
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
            // Info card with better visual cue
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F5EE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF0D723F).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF0D723F),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Dapatkan bonus dari hasil penjualan sampahmu untuk jenis sampah tertentu.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section title with required indicator
            Row(
              children: [
                const Text(
                  'Data Recycle-Giver',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                  ),
                  child: const Text(
                    'Wajib diisi',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Isi manual atau pilih dari opsi:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.touch_app,
                              size: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      // Enhanced phone input field with visual cue
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'No. Ponsel: +62',
                              prefixIcon: const Icon(Icons.phone_android_outlined, color: Color(0xFF0D723F)),
                              border: InputBorder.none,
                              suffixIcon: const Icon(Icons.edit, color: Colors.grey),
                            ),
                          ),
                          // Animated hint text for tap indication
                          if (phoneController.text.isEmpty)
                            Positioned(
                              right: 50,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 2),
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: 0.5 + 0.5 * value,
                                    child: const Text(
                                      'Tekan untuk isi nomor',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPhoneOptionButton(
                          icon: Icons.person,
                          label: 'Profil',
                          onTap: _getPhoneFromProfile,
                        ),
                        _buildPhoneOptionButton(
                          icon: Icons.contacts,
                          label: 'Kontak',
                          onTap: _getPhoneFromContacts,
                        ),
                        _buildPhoneOptionButton(
                          icon: Icons.history,
                          label: 'Riwayat',
                          onTap: _getPhoneFromHistory,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Enhanced date picker with tap indication
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          hintText: 'Tanggal Pengantaran',
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF0D723F)),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (selectedDate == null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D723F).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Tekan untuk pilih tanggal',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF0D723F),
                                    ),
                                  ),
                                ),
                              const Icon(Icons.arrow_drop_down, color: Color(0xFF0D723F)),
                            ],
                          ),
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
                  ),
                  const Divider(),
                  // Enhanced time dropdown with visual cue
                  Stack(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.access_time, color: Color(0xFF0D723F)),
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
                          // Show confirmation
                          if (value != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Waktu $value dipilih'),
                                backgroundColor: const Color(0xFF0D723F),
                              ),
                            );
                          }
                        },
                      ),
                      if (selectedTime == null)
                        Positioned(
                          top: 15,
                          right: 36,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D723F).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Tekan untuk pilih waktu',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF0D723F),
                              ),
                            ),
                          ),
                        ),
                    ],
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
            Stack(
              children: [
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Pesan untuk pengumpul sampah...',
                    border: borderStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Color(0xFF0D723F)),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                if (messageController.text.isEmpty)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 10, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            'Tekan untuk tulis pesan',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
          animation: _buttonAnimationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _buttonAnimation.value,
              child: ElevatedButton(
                onPressed: () {
                  final phone = phoneController.text.trim();
                  final message = messageController.text.trim();

                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Silakan pilih tanggal dan waktu pengantaran'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (phone.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mohon isi nomor ponsel'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (widget.weight <= 0 || widget.selectedSubTypes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Data sampah belum lengkap'),
                        backgroundColor: Colors.red,
                      ),
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
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.map, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Cari Drop-Point Terdekat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
