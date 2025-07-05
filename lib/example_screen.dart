import 'package:flutter/material.dart';
import 'utils/safe_animation.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    // Gunakan controller yang aman
    _controller = SafeAnimation.safeController(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animasi Aman')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contoh penggunaan AnimatedContainer yang aman
            SafeAnimation.safeAnimatedContainer(
              decoration: BoxDecoration(
                color: _expanded ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(_expanded ? 50 : 10),
              ),
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: _expanded ? 200 : 100,
                width: _expanded ? 200 : 100,
                child: const Center(child: Text('Animasi Aman')),
              ),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Text(_expanded ? 'Kecilkan' : 'Besarkan'),
            ),
          ],
        ),
      ),
    );
  }
}
