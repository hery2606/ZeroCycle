import 'package:flutter/material.dart';
import 'package:zerocycle/features/cart/cart_item.dart'; // Ganti dengan path sesuai struktur project kamu

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  final List<Map<String, dynamic>> cartData = const [
    // Kosongkan array ini untuk test tampilan kosong
    // {
    //   'index': 1,
    //   'category': 'Plastik',
    //   'items': {
    //     'Botol Plastik': 5,
    //     'Wadah Plastik': 10,
    //     'Perabotan Plastik': 7,
    //   },
    // },
    // {
    //   'index': 2,
    //   'category': 'Kertas',
    //   'items': {
    //     'Kertas Koran': 2,
    //     'Kertas Karton': 22,
    //     'Kertas Lainnya': 8,
    //   },
    // },
  ];

  int get totalBerat {
    return cartData.fold(0, (sum, item) {
      final itemMap = item['items'] as Map<String, int>;
      return sum + itemMap.values.fold(0, (s, e) => s + e);
    });
  }

  int get totalCyclePoint => totalBerat * 2; // contoh: 1kg = 2 ZP

  @override
  Widget build(BuildContext context) {
    final isEmpty = cartData.isEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: isEmpty
          ? const EmptyCartWidget()
          : Column(
              children: [
                const SizedBox(height: 12),
                ...cartData.map((data) {
                  final items = data['items'] as Map<String, int>;
                  final total = items.values.fold(0, (a, b) => a + b);
                  return CartItem(
                    index: data['index'],
                    category: data['category'],
                    items: items,
                    totalWeight: total,
                  );
                }),
                const Spacer(),
                const Divider(thickness: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SummaryItem(
                        icon: Icons.attach_money_rounded,
                        title: 'Jumlah Cycle Poin:',
                        value: '$totalCyclePoint ZP',
                        iconColor: const Color(0xFFFBC252),
                      ),
                      _SummaryItem(
                        icon: Icons.monitor_weight_outlined,
                        title: 'Total Berat Sampah:',
                        value: '$totalBerat Kg',
                        iconColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D723F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cari Bank Sampah',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D723F),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty_cart.png', width: 180),
            const SizedBox(height: 20),
            const Text(
              'Keranjang kamu kosong!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ayo mulai daur ulang dengan memilih jenis sampah.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
