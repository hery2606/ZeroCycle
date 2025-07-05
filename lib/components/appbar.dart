import 'package:flutter/material.dart';
import 'package:zerocycle/features/cart/cart_page.dart'; 
import 'package:zerocycle/features/notification/notification_page.dart'; 


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
        // Notification Button with Badge
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 26,
              ),
              padding: const EdgeInsets.all(8),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );
              },
              tooltip: 'Notifikasi',
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D723F), width: 2),
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // Cart Button with Badge - Using asset image
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/keranjang.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.shopping_cart_outlined, color: Colors.white);
                  },
                ),
                padding: const EdgeInsets.all(8),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                tooltip: 'Keranjang',
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D723F), width: 2),
                ),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
