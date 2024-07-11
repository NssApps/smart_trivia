
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/presentation/providers/show_indicators_provider.dart';
import 'package:smart_trivia/presentation/providers/current_question_provider.dart';
import 'package:smart_trivia/presentation/providers/lives_provider.dart';
import 'package:smart_trivia/presentation/providers/questions_provider.dart';
import 'package:smart_trivia/presentation/providers/timer_provider.dart';

class GameOverScreen extends ConsumerWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Question> questions = ref.watch(questionsProvider);
    int currentQuestionIndex = ref.watch(currentQuestionProvider);

    return Scaffold(
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

                  const Text('😩', style: TextStyle(fontSize: 80),),

                  const Text('GAME OVER',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                    ),
                  ),

                  const SizedBox(height: 20,),

                  const Text('Correct answer'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(questions[currentQuestionIndex].correctAnswer,
                      style: const TextStyle(fontSize: 25,),
                    ),
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
                      child: const Text('Try again'),
                      
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