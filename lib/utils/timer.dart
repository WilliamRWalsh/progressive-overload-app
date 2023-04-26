import 'dart:async';

import 'package:flutter/foundation.dart';

class ClockController extends ChangeNotifier {
  int _currentTime = 0;

  ClockController() {
    _startTimer();
  }

  int get currentTime => _currentTime;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime += 1;
      notifyListeners();
    });
  }
}
