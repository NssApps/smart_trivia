

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_trivia/presentation/providers/lives_provider.dart';

class Lives extends ConsumerWidget {
  const Lives({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lives = ref.watch(livesProvider);

    return SizedBox(
      width: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lives.length,
        itemBuilder: (context, index) {
          bool isActive = lives[index];

          if(isActive) {
            return const Icon(Icons.favorite, color: Colors.orange,);
          }

          return const Icon(Icons.favorite);
        
      },),
    );
  }
}