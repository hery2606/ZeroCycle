import 'package:flutter/material.dart';
import 'package:zerocycle/screens/points/bagikan_page.dart';
import 'package:zerocycle/screens/points/penukaran_page.dart';
import 'package:zerocycle/screens/points/pencairan_page.dart';

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

          // Bagian Aksi (Kanan)
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 29.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _navigateTo(context, const BagikanPage()),
                    child: _buildActionRow(
                      assetPath: 'assets/images/Vector.png',
                      label: 'Bagikan',
                    ),
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => _navigateTo(context, const PenukaranPage()),
                    child: _buildActionRow(
                      assetPath: 'assets/images/share.png',
                      label: 'Penukaran',
                    ),
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => _navigateTo(context, const PencairanPage()),
                    child: _buildActionRow(
                      assetPath: 'assets/images/wallet.png',
                      label: 'Pencairan',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow({required String assetPath, required String label}) {
    return Row(      
      children: [
        CircleAvatar(
          radius: 12,     
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              assetPath,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
