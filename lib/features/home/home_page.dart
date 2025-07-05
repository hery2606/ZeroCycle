import 'package:flutter/material.dart';
import 'package:zerocycle/components/appbar.dart';
import 'package:zerocycle/features/home/widgets/points_card.dart';
import 'package:zerocycle/features/home/widgets/service_menu_item.dart';
import 'package:zerocycle/features/home/widgets/welcome_header_card.dart';
import 'DropOff/drop_off_screen.dart';
import 'PickUpScreen/PickUpScreen.dart';
import 'withdraw-page/withdraw.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation<double>> _menuAnimations = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Create staggered animations for menu items
    for (int i = 0; i < 3; i++) {
      final start = 0.2 + (i * 0.2);
      _menuAnimations.add(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, start + 0.6, curve: Curves.easeOutQuart),
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
      backgroundColor: const Color(0xFF0D723F),
      appBar: const Appbar(),
      body: SafeArea(
        child: Stack(
          children: [
            // Background putih dengan border radius
            Positioned.fill(
              top: 160,
              bottom: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            // Content utama
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: WelcomeHeaderCard(),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: PointsCard(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // Animated Drop Off menu item
                          AnimatedBuilder(
                            animation: _menuAnimations[0],
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  50 * (1 - _menuAnimations[0].value),
                                ),
                                child: Opacity(
                                  opacity: _menuAnimations[0].value,
                                  child: child,
                                ),
                              );
                            },
                            child: ServiceMenuItem(
                              iconPath: 'assets/images/kardus.png',
                              title: 'Drop Off',
                              subtitle: 'Antarkan langsung sampahmu',
                              backgroundColor: const Color(0xFF699ADA),
                              badge: _buildNewBadge(),
                              onTap: () => _navigateToScreen(context, const DropOffScreen()),
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Animated Pick Up menu item
                          AnimatedBuilder(
                            animation: _menuAnimations[1],
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  50 * (1 - _menuAnimations[1].value),
                                ),
                                child: Opacity(
                                  opacity: _menuAnimations[1].value,
                                  child: child,
                                ),
                              );
                            },
                            child: ServiceMenuItem(
                              iconPath: 'assets/images/pickup.png',
                              title: 'Pick Up',
                              subtitle: 'Cukup di rumah, kami siap jemput',
                              backgroundColor: const Color(0xFFD7898E),
                              onTap: () => _navigateToScreen(context, const PickUpScreen()),
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Animated Cycle Point menu item
                          AnimatedBuilder(
                            animation: _menuAnimations[2],
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  50 * (1 - _menuAnimations[2].value),
                                ),
                                child: Opacity(
                                  opacity: _menuAnimations[2].value,
                                  child: child,
                                ),
                              );
                            },
                            child: ServiceMenuItem(
                              iconPath: 'assets/images/hand_coin.png',
                              title: 'Cycle Point',
                              subtitle: 'Tukar sampahmu jadi poin',
                              backgroundColor: const Color(0xFFDC9B72),
                              badge: _buildPointsBadge(),
                              onTap: () => _navigateToScreen(context, const CyclePointWithdrawScreen()),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: screen,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
  
  Widget _buildNewBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
  
  Widget _buildPointsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        '+200 POIN',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
