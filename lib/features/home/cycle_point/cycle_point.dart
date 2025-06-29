import 'package:flutter/material.dart';

class CyclePointScreen extends StatefulWidget {
  const CyclePointScreen({super.key});

  @override
  State<CyclePointScreen> createState() => _CyclePointScreenState();
}

class _CyclePointScreenState extends State<CyclePointScreen> {
  int currentPoints = 2450;
  
  final List<Map<String, dynamic>> rewardCategories = [
    {
      'title': 'Voucher Belanja',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
      'items': [
        {'name': 'Voucher Indomaret Rp 10.000', 'points': 500, 'image': '🏪'},
        {'name': 'Voucher Alfamart Rp 15.000', 'points': 750, 'image': '🛒'},
        {'name': 'Voucher Shopee Rp 25.000', 'points': 1200, 'image': '🛍️'},
        {'name': 'Voucher Tokopedia Rp 30.000', 'points': 1500, 'image': '🛒'},
      ]
    },
    {
      'title': 'Produk Ramah Lingkungan',
      'icon': Icons.eco,
      'color': Colors.green,
      'items': [
        {'name': 'Tumbler Stainless Steel', 'points': 800, 'image': '🧊'},
        {'name': 'Tas Belanja Kain', 'points': 400, 'image': '👜'},
        {'name': 'Sedotan Bambu Set', 'points': 300, 'image': '🎋'},
        {'name': 'Lunch Box Ramah Lingkungan', 'points': 600, 'image': '🍱'},
      ]
    },
    {
      'title': 'Donasi',
      'icon': Icons.favorite,
      'color': Colors.red,
      'items': [
        {'name': 'Donasi Pohon (1 bibit)', 'points': 200, 'image': '🌱'},
        {'name': 'Donasi Pendidikan', 'points': 500, 'image': '📚'},
        {'name': 'Donasi Lingkungan', 'points': 300, 'image': '🌍'},
        {'name': 'Donasi Kesehatan', 'points': 400, 'image': '🏥'},
      ]
    },
  ];

  final List<Map<String, dynamic>> pointHistory = [
    {
      'date': '28 Jun 2025',
      'action': 'Drop Off Plastik',
      'points': '+150',
      'type': 'earned'
    },
    {
      'date': '25 Jun 2025',
      'action': 'Tukar Voucher Indomaret',
      'points': '-500',
      'type': 'spent'
    },
    {
      'date': '23 Jun 2025',
      'action': 'Pick Up Kertas',
      'points': '+200',
      'type': 'earned'
    },
    {
      'date': '20 Jun 2025',
      'action': 'Drop Off Elektronik',
      'points': '+350',
      'type': 'earned'
    },
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
          'Cycle Point',
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
          // Header dengan poin saat ini
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.stars,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Poin Kamu Saat Ini',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$currentPoints Poin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tukar poin dengan hadiah menarik',
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
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // Tab bar
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TabBar(
                        indicator: BoxDecoration(
                          color: Color(0xFF0D723F),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: 'Tukar Poin'),
                          Tab(text: 'Riwayat'),
                        ],
                      ),
                    ),
                    
                    // Tab content
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildRewardsTab(),
                          _buildHistoryTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: rewardCategories.length,
      itemBuilder: (context, index) {
        final category = rewardCategories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: category['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category['icon'],
                      color: category['color'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ],
              ),
            ),
            
            // Items grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: category['items'].length,
              itemBuilder: (context, itemIndex) {
                final item = category['items'][itemIndex];
                final canAfford = currentPoints >= item['points'];
                
                return GestureDetector(
                  onTap: canAfford ? () => _showRedeemDialog(item) : null,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: canAfford ? Colors.white : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: canAfford ? Colors.grey.shade300 : Colors.grey.shade200,
                      ),
                      boxShadow: canAfford ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Item image/emoji
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: category['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item['image'],
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Item name
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: canAfford ? const Color(0xFF2C3E50) : Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const Spacer(),
                        
                        // Points required
                        Row(
                          children: [
                            Icon(
                              Icons.stars,
                              size: 16,
                              color: canAfford ? const Color(0xFF0D723F) : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item['points']} poin',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: canAfford ? const Color(0xFF0D723F) : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        
                        if (!canAfford)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              'Poin tidak cukup',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: pointHistory.length,
      itemBuilder: (context, index) {
        final history = pointHistory[index];
        final isEarned = history['type'] == 'earned';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isEarned 
                      ? Colors.green.withOpacity(0.1) 
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isEarned ? Icons.add : Icons.remove,
                  color: isEarned ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history['action'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      history['date'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Points
              Text(
                history['points'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isEarned ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRedeemDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Konfirmasi Penukaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['image'],
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${item['points']} Poin',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D723F),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Poin setelah penukaran: ${currentPoints - item['points']} poin',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
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
                _processRedemption(item);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D723F),
              ),
              child: const Text('Tukar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _processRedemption(Map<String, dynamic> item) {
    setState(() {
      currentPoints -= item['points'] as int;
    });
    
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
                'Berhasil Ditukar!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kamu berhasil menukar ${item['name']}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sisa poin: $currentPoints',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D723F),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D723F),
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}