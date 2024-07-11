import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider = StateNotifierProvider.autoDispose<TimerNotifier, int>((ref) {
  const int timeLeft = 15;
  return TimerNotifier(timeLeft: timeLeft);
});


class TimerNotifier extends StateNotifier<int> {
  bool isLoading = false;
  final int timeLeft;
  Timer? timer;

  TimerNotifier( {required this.timeLeft } ) : super(timeLeft);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      if(mounted) {
        state = state -1;

        if(state == 0) {
          timer.cancel();
        }
      }
    });
  }

  void resetTimer() {
    state = timeLeft;
  }

  void stopTimer() {
    timer?.cancel();
  }

  int getMaxTime() {
    return timeLeft;
  }
}