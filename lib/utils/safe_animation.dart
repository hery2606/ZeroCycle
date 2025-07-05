import 'package:flutter/material.dart';

/// Kelas utilitas untuk memastikan penggunaan animasi yang aman
class SafeAnimation {
  /// Kurva animasi yang aman digunakan (tidak akan menyebabkan assertion error)
  static const List<Curve> safePresetCurves = [
    Curves.linear,
    Curves.easeIn,
    Curves.easeOut,
    Curves.easeInOut,
    Curves.fastOutSlowIn,
    Curves.bounceIn,
    Curves.bounceOut,
    Curves.decelerate,
  ];

  /// Mendapatkan kurva animasi default yang aman
  static Curve getDefaultCurve() {
    return Curves.easeInOut;
  }

  /// Mendapatkan durasi animasi default yang aman
  static Duration getDefaultDuration() {
    return const Duration(milliseconds: 300);
  }

  /// Membuat AnimatedContainer yang aman
  static Widget safeAnimatedContainer({
    required Widget child,
    BoxDecoration? decoration,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
    Duration? duration,
  }) {
    return AnimatedContainer(
      duration: duration ?? getDefaultDuration(),
      curve: getDefaultCurve(),
      decoration: decoration,
      color: color,
      padding: padding,
      margin: margin,
      alignment: alignment,
      child: child,
    );
  }

  /// Membuat AnimationController yang aman
  static AnimationController safeController(
    TickerProvider vsync, {
    Duration? duration,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration ?? getDefaultDuration(),
    );
  }
}
