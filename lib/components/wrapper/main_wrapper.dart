import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/home_page.dart';
import 'package:zerocycle/screens/account/akun_page_screen.dart';
import 'package:zerocycle/screens/penjualan/sales_screen.dart';
import 'package:zerocycle/screens/pesan/pesan_screen.dart';
import 'package:zerocycle/screens/lokasi/maps_screen.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;

  final List<Widget> _pages = const [
    HomePage(),
    SalesScreen(), // Penjualan
    PesanScreen(), // Pesan
    AkunPageScreen(), // Akun
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
      // Appbar dihapus dari MainWrapper
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fabAnimationController.reset();
          _fabAnimationController.forward();
          // TODO: Tambahkan aksi untuk lokasi
          
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(),
        child: Container(
          width: 64,
          height: 64,
        
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF27AE60), Color.fromARGB(255, 119, 173, 146)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/location2.png',
              width: 50,
              height: 50,
             
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 28,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Beranda', 0),
            _buildNavItem('Penjualan', 1),
            const SizedBox(width: 48), // Space for FAB
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
              width: 24,
              height: 24,
              color: color,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.help_outline, color: color, size: 24);
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