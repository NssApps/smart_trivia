
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trivia/domain/entities/answer.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/presentation/providers/show_indicators_provider.dart';
import 'package:smart_trivia/presentation/providers/current_question_provider.dart';
import 'package:smart_trivia/presentation/providers/lives_provider.dart';
import 'package:smart_trivia/presentation/providers/questions_provider.dart';
import 'package:smart_trivia/presentation/providers/show_next_question_button_provider.dart';
import 'package:smart_trivia/presentation/providers/timer_provider.dart';
import 'package:html/parser.dart';

class AnswerCard extends ConsumerWidget {
  final Answer answer;
  final String numAnswer; 

  const AnswerCard({super.key, required this.answer, required this.numAnswer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Question> questions = ref.watch(questionsProvider);
    int currentQuestionIndex = ref.watch(currentQuestionProvider);
    final lives = ref.watch(livesProvider);
    final showIndicators = ref.watch(showIndicatorsProvider);

    Widget _getIndicator() {
      if(showIndicators) {
        if(answer.isCorrect) {
          return const Icon(Icons.check_circle, color: Colors.green,);
        }

        return const Icon(Icons.cancel, color: Colors.red,);
        
      }

      return const SizedBox();
    }

    String parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString = parse(document.body!.text).documentElement!.text;
      return parsedString;
    }
    

    return GestureDetector(
      onTap: () {
        if(!showIndicators) {
          ref.read(timerProvider.notifier).stopTimer();
          ref.read(showIndicatorsProvider.notifier).state = true;
          // Show next question button
          ref.read(showNextQuestionButtonProvider.notifier).update((state) => true);

          if(answer.isCorrect && currentQuestionIndex == (questions.length -1) ) {
            context.go('/youWin');
          } else {
            if(!answer.isCorrect ) {
              // Remove one live
              ref.read(livesProvider.notifier).removeLive();
       
              if(ref.read(livesProvider.notifier).getCurrentLiveIndex() == lives.length) {
                context.go('/gameOver');
              } 
            }
  
          }

        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 7),
          // height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26),
            boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(5, 2), // changes position of shadow
        ),
      ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$numAnswer.'),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(parseHtmlString(answer.answer) ),
              )),
              _getIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

