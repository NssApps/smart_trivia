

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/presentation/providers/show_indicators_provider.dart';
import 'package:smart_trivia/presentation/providers/current_question_provider.dart';
import 'package:smart_trivia/presentation/providers/lives_provider.dart';
import 'package:smart_trivia/presentation/providers/questions_provider.dart';
import 'package:smart_trivia/presentation/providers/timer_provider.dart';

class YouWinScreen extends ConsumerWidget {
  const YouWinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Question> questions = ref.watch(questionsProvider);
    int currentQuestionIndex = ref.watch(currentQuestionProvider);
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/${questions.length}', style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFFB063C0),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration( 
                gradient: LinearGradient( 
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB063C0), 
                    Color(0xFFB195F9), 
                    Colors.white
                    ], 
                ), 
              ), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  const Text('🍻 🎉 🥳 🎊 🍾', style: TextStyle(fontSize: 50),),

                  const Text('GONGRATULATION',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),
                  ),

                  const SizedBox(height: 5,),

                  Text('You have completed the trivia',
                    style: Theme.of(context).textTheme.bodyLarge
                  ),

              
                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilledButton(
                      style:  ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 245, 130, 70)),
                      onPressed: () {
                        ref.read(timerProvider.notifier).resetTimer();
                        ref.read(livesProvider.notifier).resetLives();
                        ref.read(showIndicatorsProvider.notifier).state = false;
                        ref.read(currentQuestionProvider.notifier).state = 0;
                        context.go('/trivia/create');
                      }, 
                      child: const Text('Play again'),
                      
                    ),
                  ),

                  const SizedBox(height: 50,),
                ],
              ),
          )
        ],
      ),
    );
  }
}