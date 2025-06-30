import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_cart.png', width: 120),
          const SizedBox(height: 16),
          const Text(
            'Keranjang kamu kosong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ayo mulai pilih sampah untuk didaur ulang!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
