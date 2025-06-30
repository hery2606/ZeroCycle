import 'package:flutter/material.dart';
import 'package:zerocycle/features/cart/cart_page.dart'; // Ganti path sesuai lokasi file cart_page.dart

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D723F),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('assets/images/logo_1.png', height: 24),
          ),
          const SizedBox(width: 12),
          const Text(
            'ZeroCycle',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(
            'assets/images/keranjang.png',
            width: 24,
            height: 24,
            color: Colors.white,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.shopping_cart_outlined, color: Colors.white);
            },
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
      ],
    );
  }
}
