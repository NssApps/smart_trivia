import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_trivia/presentation/providers/timer_provider.dart';

class CustomTimer extends ConsumerWidget {
  const CustomTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int timeLeft = ref.watch(timerProvider);
    int maxTime = ref.watch(timerProvider.notifier).getMaxTime();

    return Center(
      child: Stack(
        // fit: StackFit.expand,
        alignment: Alignment.center,
        children: [ 
          Container(
            child: Text('$timeLeft',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black54
            ),),
          ),

          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: const Color.fromARGB(255, 245, 130, 70),
              valueColor: const AlwaysStoppedAnimation( Colors.white70),
              strokeWidth: 10,
              value: 1 - timeLeft / maxTime,
            )
          )
        ]
      ),
    );
  }
}