import 'package:flutter/material.dart';

class ServiceMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Widget? badge; // Added badge parameter

  const ServiceMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    this.onTap,
    this.badge, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      // Add badge if provided
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        badge!,
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
