import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/DropOff/detail_pengantaran_screen.dart';

class DetailWasteScreen extends StatefulWidget {
  final String wasteType;
  final String iconPath;
  final List<String> subWasteTypes;
  final String estimatedPriceRange;

  const DetailWasteScreen({
    super.key,
    required this.wasteType,
    required this.iconPath,
    required this.subWasteTypes,
    required this.estimatedPriceRange,
  });

  @override
  State<DetailWasteScreen> createState() => _DetailWasteScreenState();
}

class _DetailWasteScreenState extends State<DetailWasteScreen> {
  int weight = 0;
  final selectedSubTypes = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jenis Sampah", style: const TextStyle(fontWeight: FontWeight.bold)),
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
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFFBE6BF),
                  child: Image.asset(widget.iconPath, width: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Perkiraan Berat", style: TextStyle(fontSize: 14)),
                    Text(widget.wasteType, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (weight > 0) setState(() => weight--);
                        },
                      ),
                      Text(
                        '$weight Kg',
                        style: const TextStyle(
                          color: Color(0xFF0D723F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => weight++),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Sub Jenis Sampah", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: widget.subWasteTypes.map((type) {
                  final isSelected = selectedSubTypes.contains(type);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedSubTypes.remove(type);
                        } else {
                          selectedSubTypes.add(type);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected ? const Color(0xFFF0F9F5) : Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(type)),
                          Checkbox(
                            value: isSelected,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  selectedSubTypes.add(type);
                                } else {
                                  selectedSubTypes.remove(type);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D723F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.estimatedPriceRange}\nEstimasi Harga/Kg',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),                
                      const Spacer(), 
                  ElevatedButton(
                    onPressed: () {
                      if (weight > 0 && selectedSubTypes.isNotEmpty) {
                        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPengantaranScreen(
      weight: weight.toDouble(), // ubah int ke double
      selectedSubTypes: selectedSubTypes.toList(), // ubah Set ke List
    ),
  ),
);

      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi semua data terlebih dahulu.')),
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
                      'Lanjut',
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
