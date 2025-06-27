import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/home_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Placeholder(), // Halaman Penjualan
    Placeholder(), // Halaman Pesan
    Placeholder(), // Halaman Akun
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: Container(
        width: 60,  // Diperbesar dari sebelumnya
        height: 60, // Diperbesar dari sebelumnya
        decoration: BoxDecoration(
          color: const Color(0xFF27AE60),
          shape: BoxShape.circle, // Bentuk bulat sempurna
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _fabAnimationController.reset();
              _fabAnimationController.forward();
              // Aksi untuk tombol lokasi
            },
            child: Center(
              child: Image.asset(
                'assets/images/location2.png',
                width: 32,  // Gambar diperbesar
                height: 32, // Gambar diperbesar
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 32,
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Beranda', 0),
            _buildNavItem('Penjualan', 1),
            const SizedBox(width: 48), // Space untuk FAB yang lebih besar
            _buildNavItem('Pesan', 2),
            _buildNavItem('Akun', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFF0D723F) : Colors.grey;

    String getIconPath() {
      switch (label) {
        case 'Beranda':
          return 'assets/images/home.png';
        case 'Penjualan':
          return 'assets/images/lets-icons_order.png';
        case 'Pesan':
          return 'assets/images/pesan.png';
        case 'Akun':
          return 'assets/images/account.png';
        default:
          return 'assets/images/home.png';
      }
    }

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              getIconPath(),
              color: color,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.help_outline,
                  color: color,
                  size: 24,
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}