import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final int index;
  final String category;
  final Map<String, int> items;
  final int totalWeight;

  const CartItem({
    super.key,
    required this.index,
    required this.category,
    required this.items,
    required this.totalWeight,
  });

  String _getIconPath(String category) {
    switch (category.toLowerCase()) {
      case 'kertas':
        return 'assets/images/kertas.png';
      case 'plastik':
        return 'assets/images/botol.png';
      case 'elektronik':
        return 'assets/images/elektronik.png';
      case 'botol kaca':
        return 'assets/images/botolkaca.png';
      default:
        return 'assets/images/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconPath = _getIconPath(category);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFF1B7748),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, 
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              // ICON DAN DETAIL SECTION
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    // Icon dengan background putih
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          iconPath, 
                          width: 35,
                          height: 35,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Kategori dan detail items
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 7),
                          ...items.entries.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                                '${e.key}: ${e.value}Kg',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // TOTAL BERAT SECTION
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Berat Sampah',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalWeight Kg',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        
        // BULATAN ANGKA INDEX
        Positioned(
          top: -6,
          left: 8,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF0E5B35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}