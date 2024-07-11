
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/presentation/providers/show_indicators_provider.dart';
import 'package:smart_trivia/presentation/providers/current_question_provider.dart';
import 'package:smart_trivia/presentation/providers/lives_provider.dart';
import 'package:smart_trivia/presentation/providers/questions_provider.dart';
import 'package:smart_trivia/presentation/providers/show_next_question_button_provider.dart';
import 'package:smart_trivia/presentation/providers/timer_provider.dart';
import 'package:smart_trivia/presentation/screens/trivia/widgets/answers_list.dart';
import 'package:smart_trivia/presentation/screens/trivia/widgets/lives.dart';
import 'package:smart_trivia/presentation/screens/trivia/widgets/question_container.dart';
import 'package:smart_trivia/presentation/screens/widgets/custom_timer.dart';

class TriviaScreen extends ConsumerStatefulWidget {
  const TriviaScreen({super.key});

  @override
  TriviaScreenState createState() => TriviaScreenState();
}

class TriviaScreenState extends ConsumerState<TriviaScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(questionsProvider.notifier).getQuestions();
    ref.read(timerProvider.notifier).startTimer();
  }

  void _showNextQuestion() {
    ref.read(currentQuestionProvider.notifier).state++;
  }

  void _showDialog() {
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Exit?'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          CupertinoDialogAction(
            child: const Text("Yes"),
            onPressed: () {
              ref.read(timerProvider.notifier).resetTimer();
              ref.read(livesProvider.notifier).resetLives();
              ref.read(showIndicatorsProvider.notifier).state = false;
              ref.read(currentQuestionProvider.notifier).state = 0;
              context.go('/trivia/create');
            },
          ),

          CupertinoDialogAction(
            child: const Text("No"),
            onPressed: () => context.pop(),
          ),

        ],
      );
      
    },);
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = ref.watch(questionsProvider);
    int currentQuestionIndex = ref.watch(currentQuestionProvider);
    final lives = ref.watch(livesProvider);
    final showNextQuestionButton = ref.watch(showNextQuestionButtonProvider);
    

      ref.listen(timerProvider, (previous, next) { 
        if(next == 0) {
          // Remove one live
          ref.read(livesProvider.notifier).removeLive();
          // Show next question button
          ref.read(showNextQuestionButtonProvider.notifier).update((state) => true);
          ref.read(showIndicatorsProvider.notifier).state = true;
          // Check if is the last question
          if(ref.read(livesProvider.notifier).getCurrentLiveIndex() == lives.length) {
            context.go('/gameOver');
          }
          return;
        }
    });

    if(questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2,),
        ),
      );
    }

    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/${questions.length}', style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFFB063C0),
        leading: IconButton.filled(
          onPressed: () => _showDialog(), 
          icon: const Icon(Icons.close_rounded),
          color: Colors.black54,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white54)
          ),
        ),
        actions: const [
          Lives()
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              // height: 500,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: QuestionContainer(question: questions[currentQuestionIndex],),
              ),
            ),


            const SizedBox(height: 20,),

            const CustomTimer(),

            const SizedBox(height: 20,),

            AnswersList(answers: questions[currentQuestionIndex].allAnswers ?? [] ),

            // if(currentQuestionIndex < questions.length -1  && answerIsSelected)
            if(showNextQuestionButton)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FilledButton(
                  style:  ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 245, 130, 70)),
                  onPressed: () {
                    if(currentQuestionIndex < questions.length -1) {
                      _showNextQuestion();
                      // Reset timer
                      ref.read(timerProvider.notifier).resetTimer();
                      // Start timer
                      ref.read(timerProvider.notifier).startTimer();
                      // Reset answerIsSelectedProvider
                      ref.read(showIndicatorsProvider.notifier).state = false;
                      // Hide next question button
                      ref.read(showNextQuestionButtonProvider.notifier).update((state) => false);
                    }

                  }, 
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next question'),
                      Icon(Icons.chevron_right_rounded)
                    ],
                  ),
                  
                ),
              ),

             
          ],
        ),
      ),
      
    ); 
  }
}

