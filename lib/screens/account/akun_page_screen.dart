import 'package:flutter/material.dart';
import 'package:zerocycle/features/home/withdraw-page/WithdrawPage.dart';
import 'package:zerocycle/screens/account/transaction_history_screen.dart';
import 'package:zerocycle/screens/account/edit_profile_screen.dart';
import 'package:zerocycle/screens/account/feedback_screen.dart';
import 'package:zerocycle/screens/account/location_settings_screen.dart';
import 'package:zerocycle/screens/account/phone_number_settings_screen.dart';
import 'dart:math' as math;

class AkunPageScreen extends StatefulWidget {
  const AkunPageScreen({super.key});

  @override
  State<AkunPageScreen> createState() => _AkunPageScreenState();
}

class _AkunPageScreenState extends State<AkunPageScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation<double>> _menuAnimations = [];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    // Create staggered animations for menu items
    for (int i = 0; i < 8; i++) {
      final start = i * 0.1;
      _menuAnimations.add(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, start + 0.6, curve: Curves.easeOut),
        ),
      );
    }
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // Animated App Bar
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1B7748),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final expandRatio = (top - kToolbarHeight) / (200 - kToolbarHeight);
                final opacity = math.max(0, expandRatio);
                
                return FlexibleSpaceBar(
                    centerTitle: false,
                    title: AnimatedOpacity(
                    opacity: 1.0 - opacity,
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      'Akun Saya',
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                    ),
                    ),
                    titlePadding: EdgeInsets.only(
                    left: 16,
                    bottom: 16 * (1 - expandRatio),
                    top: expandRatio < 0.5 ? kToolbarHeight / 4 : 0,
                    ),
                    expandedTitleScale: 1.0,
                    collapseMode: CollapseMode.pin,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF1B7748),
                              const Color(0xFF0D723F),
                            ],
                          ),
                        ),
                      ),
                      // Decorative pattern
                      Opacity(
                        opacity: 0.1,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/pattern.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Profile content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Hero(
                                  tag: 'profile-pic',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage('assets/images/avatar.png'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Nama Pengguna',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: const [
                                          Icon(Icons.email_outlined, color: Colors.white70, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            'email@example.com',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Points Card
          SliverToBoxAdapter(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFDEF5E7), Color(0xFFC1E9CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.recycling, color: Color(0xFF1B7748), size: 32),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Total Poin',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF444444),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '1,200',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B7748),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WithdrawPage()),
                          ),
                          icon: const Icon(Icons.redeem, size: 18),
                          label: const Text('Tukar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B7748),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.white54,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1B7748)),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Level 2: Recycle Enthusiast',
                          style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                        ),
                        Text(
                          '600/1000 to Level 3',
                          style: TextStyle(fontSize: 12, color: Color(0xFF1B7748), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Utama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Main menu items with staggered animation
                  FadeTransition(
                    opacity: _menuAnimations[0],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[0]),
                      child: _buildMenuItem(
                        context,
                        Icons.history,
                        'Riwayat Transaksi',
                        'Lihat semua aktivitas daur ulang Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const TransactionHistoryScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _menuAnimations[1],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[1]),
                      child: _buildMenuItem(
                        context,
                        Icons.card_giftcard,
                        'Tukar Poin',
                        'Dapatkan hadiah dari poin Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const WithdrawPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _menuAnimations[2],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[2]),
                      child: _buildMenuItem(
                        context,
                        Icons.edit,
                        'Edit Profil',
                        'Perbarui informasi pribadi Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const EditProfileScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _menuAnimations[3],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[3]),
                      child: _buildMenuItem(
                        context,
                        Icons.feedback,
                        'Umpan Balik',
                        'Beri tahu kami pendapat Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const FeedbackScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  const Text(
                    'Pengaturan Akun',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  FadeTransition(
                    opacity: _menuAnimations[4],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[4]),
                      child: _buildMenuItem(
                        context,
                        Icons.location_on,
                        'Lokasi',
                        'Kelola alamat tersimpan Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const LocationSettingsScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _menuAnimations[5],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[5]),
                      child: _buildMenuItem(
                        context,
                        Icons.phone,
                        'Nomor HP',
                        'Kelola nomor telepon Anda',
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const PhoneNumberSettingsScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _menuAnimations[6],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[6]),
                      child: _buildMenuItem(
                        context,
                        Icons.notifications,
                        'Notifikasi',
                        'Atur preferensi notifikasi',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fitur Notifikasi akan segera hadir')),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  FadeTransition(
                    opacity: _menuAnimations[7],
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(_menuAnimations[7]),
                      child: _buildMenuItem(
                        context,
                        Icons.logout,
                        'Logout',
                        'Keluar dari akun Anda',
                        isDestructive: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Konfirmasi Logout'),
                              content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Logout', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // App version
                  Center(
                    child: Text(
                      'ZeroCycle v1.0.0',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDestructive 
                        ? Colors.red.withOpacity(0.1)
                        : const Color(0xFF1B7748).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon, 
                    color: isDestructive ? Colors.red : const Color(0xFF1B7748),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDestructive ? Colors.red : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
