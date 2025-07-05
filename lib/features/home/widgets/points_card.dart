import 'package:flutter/material.dart';
import 'package:zerocycle/screens/points/bagikan_page.dart';
import 'package:zerocycle/screens/points/penukaran_page.dart';
import 'package:zerocycle/features/home/withdraw-page/withdraw.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  final int points = 1000; // Ubah ini dengan nilai dinamis jika perlu

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  double _getFontSize(String text) {
    final length = text.length;

    if (length <= 2) {
      return 48;
    } else if (length == 3) {
      return 42;
    } else if (length == 4) {
      return 36;
    } else {
      return 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bagian Poin (Kiri)
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(255, 171, 171, 171),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/cycle.png'),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Cycle Points',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      points.toString(),
                      style: TextStyle(
                        fontSize: _getFontSize(points.toString()),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bagian Aksi (Kanan) - Improved
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacing at the top for visual balance
                  const SizedBox(height: 8),
                  
                  // Pencairan button
                  _buildActionButton(
                    context: context,
                    assetPath: 'assets/images/wallet.png',
                    label: 'Pencairan',
                    onTap: () => _navigateTo(context, const CyclePointWithdrawScreen()),
                  ),
                  
                  // Consistent spacing between buttons
                  const SizedBox(height: 14),
                  
                  // Penukaran button
                  _buildActionButton(
                    context: context,
                    assetPath: 'assets/images/share.png',
                    label: 'Penukaran',
                    onTap: () => _navigateTo(context, const PenukaranPage()),
                  ),
                  
                  // Consistent spacing between buttons
                  const SizedBox(height: 14),
                  
                  // Bagikan button
                  _buildActionButton(
                    context: context,
                    assetPath: 'assets/images/Vector.png',
                    label: 'Bagikan',
                    onTap: () => _navigateTo(context, const BagikanPage()),
                  ),
                  
                  // Bottom spacing for visual balance
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String assetPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              // Circle with icon (keeping black background as requested)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    assetPath,
                    color: Colors.white,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              // Spacing between icon and text
              const SizedBox(width: 14),
              
              // Text label
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              
              // Arrow indicator to show it's tappable
              Icon(
                Icons.chevron_right,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
