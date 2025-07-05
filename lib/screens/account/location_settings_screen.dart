import 'package:flutter/material.dart';

class LocationSettingsScreen extends StatefulWidget {
  const LocationSettingsScreen({super.key});

  @override
  State<LocationSettingsScreen> createState() => _LocationSettingsScreenState();
}

class _LocationSettingsScreenState extends State<LocationSettingsScreen> {
  bool _locationPermissionEnabled = true;
  bool _notificationEnabled = true;
  String _selectedAddress = 'Rumah';
  
  final List<Map<String, dynamic>> _savedAddresses = [
    {
      'id': '1',
      'name': 'Rumah',
      'address': 'Jl. Contoh No. 123, Kecamatan A, Kota B',
      'isDefault': true,
    },
    {
      'id': '2',
      'name': 'Kantor',
      'address': 'Jl. Kerja No. 456, Kecamatan C, Kota D',
      'isDefault': false,
    },
    {
      'id': '3',
      'name': 'Kampus',
      'address': 'Jl. Pendidikan No. 789, Kecamatan E, Kota F',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7748),
        title: const Text(
          'Pengaturan Lokasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Preferensi Lokasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Izin Lokasi'),
                    subtitle: const Text('Izinkan aplikasi mengakses lokasi Anda'),
                    value: _locationPermissionEnabled,
                    activeColor: const Color(0xFF1B7748),
                    onChanged: (value) {
                      setState(() {
                        _locationPermissionEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Notifikasi Lokasi'),
                    subtitle: const Text('Terima notifikasi saat berada di dekat drop-off point'),
                    value: _notificationEnabled,
                    activeColor: const Color(0xFF1B7748),
                    onChanged: (value) {
                      setState(() {
                        _notificationEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alamat Tersimpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add, color: Color(0xFF1B7748)),
                    label: const Text(
                      'Tambah',
                      style: TextStyle(color: Color(0xFF1B7748)),
                    ),
                    onPressed: () {
                      // Implement add address functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tambah alamat baru')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _savedAddresses.length,
              itemBuilder: (context, index) {
                final address = _savedAddresses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Radio(
                          value: address['name'],
                          groupValue: _selectedAddress,
                          activeColor: const Color(0xFF1B7748),
                          onChanged: (value) {
                            setState(() {
                              _selectedAddress = value.toString();
                            });
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    address['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (address['isDefault'])
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDEF5E7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Default',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF1B7748),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                address['address'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            // Implement edit address functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Edit alamat ${address['name']}'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7748),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Save location settings
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengaturan lokasi disimpan'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Simpan Pengaturan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
