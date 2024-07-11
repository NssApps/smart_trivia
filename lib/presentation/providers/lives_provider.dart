

import 'package:flutter_riverpod/flutter_riverpod.dart';

final livesProvider = StateNotifierProvider.autoDispose<LivesNotifier, List<bool>>((ref) {
  return LivesNotifier();
});


class LivesNotifier extends StateNotifier<List<bool>> {
  int currentLiveIndex = 0;
  int maxNumLive = 3;

  LivesNotifier( ) : super([true, true, true]);

  Future<void> removeLive() async {
    List<bool> lives = state;

    if(currentLiveIndex < state.length) {
      lives[currentLiveIndex++] = false;
      state = [...lives];
    }  
  }

  int getCurrentLiveIndex() {
    return currentLiveIndex;
  }

  void resetLives() {
    currentLiveIndex = 0;
    List<bool> lives = [];
    for(int i = 0; i <maxNumLive; i++) {
      lives.add(true);
    }
    state = lives;
  }

}