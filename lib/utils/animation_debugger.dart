import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class AnimationDebugger {
  /// Flag untuk mengaktifkan logging detail
  static bool enableDetailedLogs = kDebugMode;
  
  /// Daftar lokasi error animasi yang terdeteksi
  static final Set<String> _detectedErrorLocations = {};
  
  /// Inisialisasi debugger animasi
  static void initialize() {
    _setupErrorHandling();
  }
  
  /// Mengatur penanganan error khusus untuk animasi
  static void _setupErrorHandling() {
    final originalOnError = FlutterError.onError;
    
    FlutterError.onError = (FlutterErrorDetails details) {
      if (_isAnimationCurveError(details.exception)) {
        _handleAnimationError(details);
      } else if (originalOnError != null) {
        originalOnError(details);
      } else {
        FlutterError.presentError(details);
      }
    };
  }
  
  /// Memeriksa apakah exception terkait dengan kurva animasi
  static bool _isAnimationCurveError(dynamic exception) {
    final errorStr = exception.toString();
    return errorStr.contains('animation/curves.dart') || 
           errorStr.contains('AnimationController') || 
           errorStr.contains('CurvedAnimation');
  }
  
  /// Menangani error animasi
  static void _handleAnimationError(FlutterErrorDetails details) {
    final errorLocation = _getErrorLocation(details.stack ?? StackTrace.current);
    
    if (!_detectedErrorLocations.contains(errorLocation)) {
      _detectedErrorLocations.add(errorLocation);
      
      if (enableDetailedLogs) {
        developer.log(
          'Animation curve error detected at: $errorLocation',
          name: 'AnimationDebugger',
          error: details.exception,
          stackTrace: details.stack,
        );
      } else {
        debugPrint('Animation curve error detected and handled at: $errorLocation');
      }
    }
  }
  
  /// Mengekstrak lokasi error dari stack trace
  static String _getErrorLocation(StackTrace stackTrace) {
    final frames = stackTrace.toString().split('\n');
    // Cari frame pertama yang merujuk ke kode aplikasi kita, bukan framework
    for (final frame in frames) {
      if (frame.contains('zerocycle') && !frame.contains('animation_debugger.dart')) {
        return frame.trim();
      }
    }
    return 'Unknown location';
  }
}

/// Memastikan durasi animasi selalu valid
extension SafeDurationExtension on Duration {
  Duration ensureValid() {
    return inMicroseconds <= 0 ? const Duration(milliseconds: 300) : this;
  }
}

/// Provider kurva animasi yang aman
class SafeCurve {
  static Curve provide(Curve? curve) {
    return curve ?? Curves.easeInOut;
  }
}
