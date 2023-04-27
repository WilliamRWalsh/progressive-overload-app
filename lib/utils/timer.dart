import 'dart:async';

import 'package:flutter/foundation.dart';

class ClockController extends ChangeNotifier {
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  bool _disposed = false;
  int _currentTime = 0;

  ClockController() {
    _startTimer();
  }

  int get currentTime => _currentTime;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime += 1;
      if (!_disposed) {
        notifyListeners();
      }
    });
  }
}
