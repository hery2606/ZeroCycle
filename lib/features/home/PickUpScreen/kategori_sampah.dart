import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/PickUpScreen/detail_waste_screen.dart';

class KategoriSampah extends StatefulWidget {
  final bool allowMultipleSelection;
  
  const KategoriSampah({
    super.key, 
    this.allowMultipleSelection = false
  });

  @override
  State<KategoriSampah> createState() => _KategoriSampahState();
}

class _KategoriSampahState extends State<KategoriSampah> {
  final List<Map<String, dynamic>> selectedItems = [];
  final List<Map<String, dynamic>> wasteOptions = [
    {
      'type': 'Kertas',
      'iconPath': 'assets/images/kertas.png',
      'selected': false,
      'result': null
    },
    {
      'type': 'Plastik',
      'iconPath': 'assets/images/botol.png',
      'selected': false,
      'result': null
    },
    {
      'type': 'Elektronik',
      'iconPath': 'assets/images/elektronik.png',
      'selected': false,
      'result': null
    },
    {
      'type': 'Botol Kaca',
      'iconPath': 'assets/images/botolkaca.png',
      'selected': false,
      'result': null
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Pilih Jenis Sampah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const Text(
                    'Pilih jenis sampah yang akan diambil. Pemilahan sampah yang tepat membantu proses daur ulang.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D723F).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF0D723F).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.allowMultipleSelection 
                              ? Icons.check_circle_outline 
                              : Icons.info_outline,
                          color: const Color(0xFF0D723F),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.allowMultipleSelection 
                                ? 'Anda dapat memilih lebih dari satu jenis sampah'
                                : 'Semakin detail informasi yang diberikan, semakin tepat estimasi harga yang didapat',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF0D723F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  ...wasteOptions.map((option) => _buildWasteOption(
                    context, 
                    option['iconPath'], 
                    option['type'],
                    option['selected'],
                    option,
                  )),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Footer dengan tombol konfirmasi untuk multi-selection
          if (widget.allowMultipleSelection)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Text(
                    '${selectedItems.length} jenis sampah dipilih',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: selectedItems.isNotEmpty 
                        ? () => Navigator.pop(context, selectedItems)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D723F),
                      disabledBackgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Konfirmasi Pilihan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _navigateToDetailWaste(
    BuildContext context, 
    String label, 
    String iconPath, 
    Map<String, dynamic> option
  ) async {
    // Navigasi ke DetailWasteScreen dan tunggu hasil
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailWasteScreen(
          wasteType: label,
          iconPath: iconPath,
          subWasteTypes: _getSubWasteTypes(label),
          estimatedPriceRange: _getEstimatedPriceRange(label),
          initialWeight: option['result'] != null ? (option['result']['totalWeight'] ?? 0) : 0,
          initialSelectedSubTypes: option['result'] != null && option['result']['subTypeDetails'] != null
              ? (option['result']['subTypeDetails'] as List).map<String>((item) => item['name'] as String).toList()
              : [],
        ),
      ),
    );
    
    if (result != null && result is Map<String, dynamic>) {
      // Tambahkan iconPath ke hasil
      result['iconPath'] = iconPath;
      
      setState(() {
        option['result'] = result;
        option['selected'] = true;
        _updateSelectedItems();
      });
      
      // Jika tidak multi selection, langsung kembali ke halaman sebelumnya
      if (!widget.allowMultipleSelection) {
        Navigator.pop(context, [result]);
      }
    }
  }

  Widget _buildWasteOption(
    BuildContext context, 
    String iconPath, 
    String label, 
    bool isSelected,
    Map<String, dynamic> option,
  ) {
    // Hitung total berat jika opsi ini memiliki hasil
    int totalWeight = 0;
    if (option['result'] != null && option['result']['totalWeight'] != null) {
      totalWeight = option['result']['totalWeight'] as int;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected 
            ? const Color(0xFFF0F9F5) 
            : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 29, 28, 28).withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: isSelected ? const Color(0xFF0D723F) : Colors.grey.shade400,
            width: 3.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Checkbox for multi-selection
          if (widget.allowMultipleSelection)
            Checkbox(
              value: isSelected,
              activeColor: const Color(0xFF0D723F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (bool? value) {
                setState(() {
                  option['selected'] = value!;
                  
                  if (value) {
                    if (option['result'] == null) {
                      _navigateToDetailWaste(context, label, iconPath, option);
                    } else {
                      _updateSelectedItems();
                    }
                  } else {
                    _updateSelectedItems();
                  }
                });
              },
            ),
            
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF0D723F).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? const Color(0xFF0D723F) : Colors.black87,
                  ),
                ),
                if (option['result'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '$totalWeight kg · ${option['result']['subTypeDetails']?.length ?? 0} jenis',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!widget.allowMultipleSelection)
            ElevatedButton(
              onPressed: () async {
                await _navigateToDetailWaste(context, label, iconPath, option);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D723F),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Pilih',
                style: TextStyle(color: Colors.white),
              ),
            )
          else if (option['result'] != null)
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF0D723F)),
              onPressed: () async {
                await _navigateToDetailWaste(context, label, iconPath, option);
              },
            )
        ],
      ),
    );
  }
  
  void _updateSelectedItems() {
    selectedItems.clear();
    for (var option in wasteOptions) {
      if (option['selected'] == true && option['result'] != null) {
        selectedItems.add(option['result']);
      }
    }
  }

  // Helper untuk sub jenis sampah
  List<String> _getSubWasteTypes(String wasteType) {
    switch (wasteType) {
      case 'Kertas':
        return [
          'Koran',
          'Buku bekas',
          'Kertas Putih/HVS',
          'Kertas Warna/Duplek',
          'Kertas Buram',
          'Karton',
          'Kertas Lainnya',
        ];
      case 'Plastik':
        return [
          'Botol Plastik',
          'Plastik Kemasan',
          'Kantong Plastik',
          'Gelas Plastik',
          'Plastik Lainnya',
        ];
      case 'Elektronik':
        return [
          'Handphone Bekas',
          'Charger Rusak',
          'Earphone',
          'Perangkat Kecil Lainnya',
        ];
      case 'Botol Kaca':
        return [
          'Botol Minuman',
          'Toples Kaca',
          'Botol Kaca Pecah',
          'Kaca Lainnya',
        ];
      default:
        return [];
    }
  }

  // Helper untuk estimasi harga
  String _getEstimatedPriceRange(String wasteType) {
    switch (wasteType) {
      case 'Kertas':
        return 'Rp.500 sd Rp.1.500';
      case 'Plastik':
        return 'Rp.300 sd Rp.1.000';
      case 'Elektronik':
        return 'Rp.2.000 sd Rp.5.000';
      case 'Botol Kaca':
        return 'Rp.200 sd Rp.800';
      default:
        return 'Rp.0 sd Rp.0';
    }
  }
}
