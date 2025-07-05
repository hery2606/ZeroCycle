import 'package:flutter/material.dart';

/// Class bantuan untuk animasi yang aman
class SafeAnimation {
  /// Memastikan durasi tidak nol atau negatif
  static Duration safeDuration(Duration? duration) {
    return duration == null || duration.inMilliseconds <= 0
        ? const Duration(milliseconds: 300)
        : duration;
  }

  /// Memastikan kurva animasi tidak null
  static Curve safeCurve(Curve? curve) {
    return curve ?? Curves.linear;
  }
}

/// Extension untuk mempermudah penggunaan
extension AnimationExtensions on Widget {
  Widget withSafeAnimation({
    required Duration duration,
    Curve? curve,
    required Widget Function(BuildContext, Animation<double>) builder,
  }) {
    return AnimatedBuilder(
      animation: AnimationController(
        duration: SafeAnimation.safeDuration(duration),
        vsync: NavigatorState(),
      ),
      builder: (context, child) => builder(
        context,
        CurvedAnimation(
          parent: AnimationController.unbounded(
            duration: SafeAnimation.safeDuration(duration),
            vsync: NavigatorState(),
          ),
          curve: SafeAnimation.safeCurve(curve),
        ),
      ),
    );
  }
}
