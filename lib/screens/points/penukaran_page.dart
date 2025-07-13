import 'package:flutter/material.dart';

class PenukaranPage extends StatefulWidget {
  const PenukaranPage({super.key});

  @override
  State<PenukaranPage> createState() => _PenukaranPageState();
}

class _PenukaranPageState extends State<PenukaranPage> {
  final int userPoints = 1000; // Simulasi poin pengguna
  String selectedCategory = 'Semua';
  final List<String> categories = [
    'Semua',
    'Voucher',
    'Donasi',
    'Produk',
    'Partner'
  ];
  
  final List<Map<String, dynamic>> redeemItems = [
    {
      'name': 'Voucher Diskon 50% GreenMart',
      'image': 'assets/images/voucher1.png',
      'points': 250,
      'description': 'Diskon 50% untuk pembelian produk ramah lingkungan',
      'category': 'Voucher',
      'popular': true,
    },
    {
      'name': 'Donasi Tanam 1 Pohon',
      'image': 'assets/images/tree.png',
      'points': 500,
      'description': 'Donasikan untuk penanaman 1 pohon di area kritis',
      'category': 'Donasi',
      'popular': false,
    },
    {
      'name': 'Tumbler Eco Friendly',
      'image': 'assets/images/tumbler.png',
      'points': 750,
      'description': 'Tumbler ramah lingkungan dari material daur ulang',
      'category': 'Produk',
      'popular': true,
    },
    {
      'name': 'Voucher Transport GoGreen',
      'image': 'assets/images/transport.png',
      'points': 300,
      'description': 'Voucher transportasi ramah lingkungan',
      'category': 'Voucher',
      'popular': false,
    },
    {
      'name': 'Diskon 25% ZeroCafe',
      'image': 'assets/images/cafe.png',
      'points': 200,
      'description': 'Diskon untuk pembelian makanan di ZeroCafe',
      'category': 'Partner',
      'popular': true,
    },
    {
      'name': 'Donasi Edukasi Lingkungan',
      'image': 'assets/images/education.png',
      'points': 400,
      'description': 'Bantu edukasi lingkungan untuk anak-anak',
      'category': 'Donasi',
      'popular': false,
    },
  ];
  
  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 'Semua') {
      return redeemItems;
    }
    return redeemItems.where((item) => item['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Penukaran Points',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header dengan total poin
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/cycle.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cycle Points Anda',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      userPoints.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D723F),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke riwayat penukaran
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D723F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Riwayat', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          
          // Kategori filter
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) => 
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      }
                    },
                    selectedColor: const Color(0xFF0D723F).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: selectedCategory == category 
                          ? const Color(0xFF0D723F)
                          : Colors.black,
                      fontWeight: selectedCategory == category 
                          ? FontWeight.bold 
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
          
          // Penawaran populer
          if (selectedCategory == 'Semua') ...[
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Penawaran Populer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: Color(0xFF0D723F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Horizontal scroll untuk penawaran populer
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: redeemItems
                    .where((item) => item['popular'] == true)
                    .map((item) => _buildPopularItem(item))
                    .toList(),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Semua Penawaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          
          // Daftar penawaran penukaran points
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('Tidak ada penawaran tersedia'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) => _buildRedeemItem(filteredItems[index]),
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPopularItem(Map<String, dynamic> item) {
    final bool canRedeem = userPoints >= item['points'];
    
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with points overlay
          Stack(
            children: [
              // Placeholder for image - replace with actual image when available
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  item['image'],
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              // Points badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: canRedeem ? const Color(0xFF0D723F) : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/cycle.png'),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['points'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['description'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRedeemItem(Map<String, dynamic> item) {
    final bool canRedeem = userPoints >= item['points'];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with points overlay
          Stack(
            children: [
              // Placeholder for image - replace with actual image when available
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  item['image'],
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              // Points badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: canRedeem ? const Color(0xFF0D723F) : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/cycle.png'),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['points'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: canRedeem ? () => _showRedeemDialog(context, item) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D723F),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    child: Text(
                      canRedeem ? 'Tukarkan' : 'Poin tidak cukup',
                      style: TextStyle(
                        color: canRedeem ? Colors.white : Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showRedeemDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Penukaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              item['image'],
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                size: 100,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              item['description'],
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/cycle.png'),
                ),
                const SizedBox(width: 8),
                Text(
                  '${item['points']} poin',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF0D723F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Apakah Anda yakin ingin menukarkan poin untuk penawaran ini?',
              textAlign: TextAlign.center,
            ),
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
              _showSuccessDialog(context, item);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D723F),
            ),
            child: const Text('Tukarkan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  
  void _showSuccessDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              'Penukaran Berhasil!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Anda berhasil menukar ${item['points']} poin dengan ${item['name']}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D723F),
              ),
              child: const Text('Selesai', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
