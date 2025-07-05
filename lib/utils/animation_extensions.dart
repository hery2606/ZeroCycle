import 'package:flutter/material.dart';
import 'animation_debugger.dart';

/// Ekstensi untuk AnimationController
extension SafeAnimationController on AnimationController {
  /// Membuat AnimationController dengan durasi yang aman
  static AnimationController safe({
    required TickerProvider vsync,
    Duration? duration,
    Duration? reverseDuration,
    double initialValue = 0.0,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    String? debugLabel,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: (duration ?? const Duration(milliseconds: 300)).ensureValid(),
      reverseDuration: reverseDuration?.ensureValid(),
      value: initialValue,
      lowerBound: lowerBound,
      upperBound: upperBound,
      debugLabel: debugLabel,
    );
  }
}

/// Ekstensi untuk Widget yang memerlukan animasi
extension SafeAnimatedWidgetExtension on Widget {
  /// Membungkus widget dengan AnimatedContainer yang aman
  Widget withSafeAnimatedContainer({
    Duration? duration,
    Curve? curve,
    required BoxDecoration Function(BuildContext) decorationBuilder,
    AlignmentGeometry? alignment,
  }) {
    return Builder(
      builder: (context) => AnimatedContainer(
        duration: (duration ?? const Duration(milliseconds: 300)).ensureValid(),
        curve: SafeCurve.provide(curve),
        decoration: decorationBuilder(context),
        alignment: alignment,
        child: this,
      ),
    );
  }
}
