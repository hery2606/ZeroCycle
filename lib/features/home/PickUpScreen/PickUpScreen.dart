import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/PickUpScreen/kategori_sampah.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  String selectedWasteType = 'Pilih Jenis Sampah';
  String selectedTimeSlot = '09:00 - 11:00';
  DateTime selectedDate = DateTime.now();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  // Ubah untuk mendukung multi kategori
  List<Map<String, dynamic>> selectedWasteItems = [];
  int totalWeight = 0;
  
  final List<String> wasteTypes = [
    'Plastik',
    'Kertas',
    'Elektronik',
    'Botol Kaca',
    'Logam',
    'Organik'
  ];

  final List<String> timeSlots = [
    '09:00 - 11:00',
    '11:00 - 13:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
    '17:00 - 19:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D723F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D723F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pick Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header dengan ilustrasi
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.local_shipping,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Layanan Pick Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Kami akan datang mengambil sampahmu',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Konten utama
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Form alamat
                  _buildSectionTitle('Alamat Penjemputan'),
                  TextField(
                    controller: _addressController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat lengkap...',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0D723F)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Nomor telepon
                  _buildSectionTitle('Nomor Telepon'),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Nomor telepon yang bisa dihubungi',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0D723F)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Jenis sampah - Ubah menjadi tombol navigasi
                  _buildSectionTitle('Jenis Sampah'),
                  InkWell(
                    onTap: () => _navigateToKategoriSampah(),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.recycling, color: Color(0xFF0D723F)),
                          const SizedBox(width: 12),
                          Text(
                            selectedWasteItems.isEmpty 
                                ? 'Pilih Jenis Sampah' 
                                : '${selectedWasteItems.length} jenis sampah dipilih',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  
                  // Tampilkan detail sampah yang dipilih
                  if (selectedWasteItems.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedWasteItems.length,
                      itemBuilder: (context, index) {
                        final wasteItem = selectedWasteItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F9F5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF0D723F).withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (wasteItem['iconPath'] != null && wasteItem['iconPath'].isNotEmpty)
                                    Image.asset(
                                      wasteItem['iconPath'],
                                      width: 24,
                                      height: 24,
                                    ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${wasteItem['wasteType']} (${wasteItem['totalWeight']} kg)',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D723F),
                                    ),
                                  ),
                                  const Spacer(),
                                  // Tombol hapus
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 18, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        selectedWasteItems.removeAt(index);
                                        _updateTotalWeight();
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                              if (wasteItem['subTypeDetails'] != null && 
                                  (wasteItem['subTypeDetails'] as List).isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children: (wasteItem['subTypeDetails'] as List).map<Widget>((subType) {
                                    return Chip(
                                      label: Text(
                                        '${subType['name']} (${subType['weight']} kg)',
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF0D723F)),
                                      ),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: const Color(0xFF0D723F).withOpacity(0.3)),
                                      padding: EdgeInsets.zero,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                    
                    // Tampilkan total berat
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D723F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.scale, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Total: $totalWeight kg',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 20),
                  
                  // Pilih tanggal
                  _buildSectionTitle('Tanggal Penjemputan'),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 12),
                          Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Pilih waktu
                  _buildSectionTitle('Waktu Penjemputan'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTimeSlot,
                        isExpanded: true,
                        icon: const Icon(Icons.access_time),
                        items: timeSlots.map((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTimeSlot = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Catatan tambahan
                  _buildSectionTitle('Catatan Tambahan'),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Patokan alamat, instruksi khusus, dll...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0D723F)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Info biaya
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Layanan pick up gratis untuk sampah minimal 5kg',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tombol konfirmasi
                  ElevatedButton(
                    onPressed: () {
                      _validateAndSubmit();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D723F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Jadwalkan Pick Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2C3E50),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0D723F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _validateAndSubmit() {
    if (_addressController.text.isEmpty) {
      _showErrorDialog('Alamat harus diisi');
      return;
    }
    
    if (_phoneController.text.isEmpty) {
      _showErrorDialog('Nomor telepon harus diisi');
      return;
    }
    
    _showConfirmationDialog();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Perhatian'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToKategoriSampah() async {
    // Navigasi ke halaman KategoriSampah
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const KategoriSampah(allowMultipleSelection: true),
      ),
    );
    
    // Proses hasil yang dikembalikan
    if (result != null && result is List<Map<String, dynamic>>) {
      setState(() {
        selectedWasteItems = result;
        _updateTotalWeight();
      });
    }
  }
  
  void _updateTotalWeight() {
    totalWeight = 0;
    for (var item in selectedWasteItems) {
      totalWeight += (item['totalWeight'] as int);
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Konfirmasi Pick Up'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alamat: ${_addressController.text}'),
              const SizedBox(height: 8),
              Text('Telepon: ${_phoneController.text}'),
              const SizedBox(height: 8),
              if (selectedWasteItems.isNotEmpty) ...[
                const Text('Jenis Sampah:'),
                const SizedBox(height: 4),
                ...selectedWasteItems.map((item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ${item['wasteType']} (${item['totalWeight']} kg)'),
                      if ((item['subTypeDetails'] as List).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (item['subTypeDetails'] as List).map<Widget>((subType) => 
                              Text('  - ${subType['name']}: ${subType['weight']} kg')
                            ).toList(),
                          ),
                        )
                    ],
                  );
                }),
                Text('Total Berat: $totalWeight kg'),
              ],
              const SizedBox(height: 8),
              Text('Tanggal: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              const SizedBox(height: 8),
              Text('Waktu: $selectedTimeSlot'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D723F),
              ),
              child: const Text('Konfirmasi', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                size: 64,
                color: Color(0xFF0D723F),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pick Up Terjadwal!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tim kami akan datang sesuai jadwal yang telah ditentukan. Terima kasih!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D723F),
                ),
                child: const Text('Kembali ke Home', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}