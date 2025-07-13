import 'package:flutter/material.dart';
import 'package:zerocycle/components/appbar.dart';
import 'package:zerocycle/features/home/widgets/points_card.dart';
import 'package:zerocycle/features/home/widgets/service_menu_item.dart';
import 'package:zerocycle/features/home/widgets/welcome_header_card.dart';
import 'DropOff/drop_off_screen.dart';
import 'PickUpScreen/PickUpScreen.dart';
import 'withdraw-page/withdraw.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D723F),
      appBar: const Appbar(), // Ganti AppBar bawaan dengan Appbar kustom
      body: SafeArea(
        child: Stack(
          children: [
            // Background putih dengan border radius
            Positioned.fill(
              top: 160,
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
                          ServiceMenuItem(
                            iconPath: 'assets/images/kardus.png',
                            title: 'Drop Off',
                            subtitle: 'Antarkan langsung sampahmu',
                            backgroundColor: const Color(0xFF699ADA),
                            onTap: () => _navigateToScreen(context, const DropOffScreen()),
                          ),
                          const SizedBox(height: 12),
                          ServiceMenuItem(
                            iconPath: 'assets/images/pickup.png',
                            title: 'Pick Up',
                            subtitle: 'Cukup di rumah, kami siap jemput',
                            backgroundColor: const Color(0xFFD7898E),
                            onTap: () => _navigateToScreen(context, const PickUpScreen()),
                          ),
                          const SizedBox(height: 12),
                          ServiceMenuItem(
                            iconPath: 'assets/images/hand_coin.png',
                            title: 'Cycle Point',
                            subtitle: 'Tukar sampahmu jadi poin',
                            backgroundColor: const Color(0xFFDC9B72),
                            onTap: () => _navigateToScreen(context, const CyclePointWithdrawScreen()),
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
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
