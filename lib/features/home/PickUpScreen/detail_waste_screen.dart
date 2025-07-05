import 'package:flutter/material.dart';

class DetailWasteScreen extends StatefulWidget {
  final String wasteType;
  final String iconPath;
  final List<String> subWasteTypes;
  final String estimatedPriceRange;
  final int initialWeight;
  final List<String> initialSelectedSubTypes;

  const DetailWasteScreen({
    super.key,
    required this.wasteType,
    required this.iconPath,
    required this.subWasteTypes,
    required this.estimatedPriceRange,
    this.initialWeight = 0,
    this.initialSelectedSubTypes = const [],
  });

  @override
  State<DetailWasteScreen> createState() => _DetailWasteScreenState();
}

class _DetailWasteScreenState extends State<DetailWasteScreen> {
  late int weight;
  late final Set<String> selectedSubTypes;
  // Map untuk menyimpan berat per sub jenis sampah
  final Map<String, int> subTypeWeights = {};

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight;
    selectedSubTypes = Set<String>.from(widget.initialSelectedSubTypes);
    
    // Inisialisasi berat untuk setiap sub jenis yang sudah dipilih sebelumnya
    if (widget.initialSelectedSubTypes.isNotEmpty) {
      for (var subType in widget.initialSelectedSubTypes) {
        subTypeWeights[subType] = 1; // Default ke 1kg
      }
    }
  }

  // Menghitung total berat dari semua sub jenis sampah
  int get totalWeight {
    int total = 0;
    subTypeWeights.forEach((_, weight) => total += weight);
    return total > 0 ? total : weight; // Gunakan weight jika tidak ada sub item yang dipilih
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jenis Sampah", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              setState(() {
                weight = 0;
                selectedSubTypes.clear();
                subTypeWeights.clear();
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF265FA9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Untuk berat sampah 1Kg ke bawah, masukkan perkiraan berat 1Kg',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Location icon with "floating" effect
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBE6BF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Positioned icon to appear floating outside circle
                    Positioned(
                      child: Transform.translate(
                        offset: const Offset(0, -5), // Shift upward to create floating effect
                        child: Image.asset(
                          widget.iconPath, 
                          width: 36, // Larger size to create overflow effect
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Perkiraan Berat", 
                      style: TextStyle(fontSize: 14)
                    ),
                    Text(
                      widget.wasteType, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)
                          ),
                          onTap: () {
                            if (weight > 0) setState(() => weight--);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(minWidth: 40),
                        child: Text(
                          '$weight Kg',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF0D723F),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                          ),
                          onTap: () => setState(() => weight++),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Sub-waste type header with improved visual
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                ),
              ),
              child: const Text(
                "Sub Jenis Sampah", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Enhanced list of sub-waste types
            Expanded(
              child: ListView(
                children: widget.subWasteTypes.map((type) {
                  final isSelected = selectedSubTypes.contains(type);
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedSubTypes.remove(type);
                            subTypeWeights.remove(type);
                          } else {
                            selectedSubTypes.add(type);
                            subTypeWeights[type] = 1; // Default ke 1kg saat dipilih
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected 
                              ? const Color(0xFF0D723F) 
                              : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? const Color(0xFFF0F9F5) : Colors.white,
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: const Color(0xFF0D723F).withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            )
                          ] : null,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Sub-waste type with location icon for visual enhancement
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0D723F).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Positioned(
                                      child: Transform.translate(
                                        offset: const Offset(0, -2), // Slight floating effect
                                        child: Icon(
                                          Icons.eco_outlined,
                                          color: const Color(0xFF0D723F),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected 
                                        ? const Color(0xFF0D723F)
                                        : Colors.black87,
                                    ),
                                  )
                                ),
                                // Custom checkbox with animation
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: isSelected 
                                        ? const Color(0xFF0D723F) 
                                        : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    color: isSelected 
                                      ? const Color(0xFF0D723F) 
                                      : Colors.transparent,
                                  ),
                                  child: isSelected 
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ) 
                                    : null,
                                ),
                              ],
                            ),
                            
                            // Tampilkan pengaturan berat jika item dipilih
                            if (isSelected) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Text(
                                    'Berat:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF0D723F)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (subTypeWeights[type]! > 1) {
                                              setState(() {
                                                subTypeWeights[type] = subTypeWeights[type]! - 1;
                                              });
                                            }
                                          },
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            child: const Icon(
                                              Icons.remove, 
                                              size: 16, 
                                              color: Color(0xFF0D723F),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: const BoxDecoration(
                                            border: Border.symmetric(
                                              vertical: BorderSide(color: Color(0xFF0D723F)),
                                            ),
                                          ),
                                          child: Text(
                                            '${subTypeWeights[type]} kg',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0D723F),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              subTypeWeights[type] = subTypeWeights[type]! + 1;
                                            });
                                          },
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            child: const Icon(
                                              Icons.add, 
                                              size: 16, 
                                              color: Color(0xFF0D723F),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Bottom pricing and action section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D723F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedSubTypes.isNotEmpty 
                            ? 'Total: $totalWeight kg' 
                            : widget.estimatedPriceRange,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          selectedSubTypes.isNotEmpty 
                            ? '${selectedSubTypes.length} jenis sampah dipilih' 
                            : 'Estimasi Harga/Kg',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),                
                  const Spacer(), 
                  ElevatedButton(
                    onPressed: () {
                      if (selectedSubTypes.isNotEmpty) {
                        // Membuat struktur data dengan berat per sub jenis
                        final subTypeDetails = <Map<String, dynamic>>[];
                        for (var subType in selectedSubTypes) {
                          subTypeDetails.add({
                            'name': subType,
                            'weight': subTypeWeights[subType] ?? 1
                          });
                        }
                        
                        // Return data back to KategoriSampah
                        final result = {
                          'wasteType': widget.wasteType,
                          'totalWeight': totalWeight,
                          'subTypeDetails': subTypeDetails,
                        };
                        
                        // Kirim data ke halaman sebelumnya
                        Navigator.pop(context, result);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Silakan pilih minimal satu jenis sampah.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27AE60),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Konfirmasi',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

