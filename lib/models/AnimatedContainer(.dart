import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatelessWidget {
  const AnimatedContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Durasi harus positif dan tidak nol
      curve: Curves.linear, // Gunakan curve yang valid, misal Curves.linear
      // ...existing code...
    );
  }
}