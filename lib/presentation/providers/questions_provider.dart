

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_trivia/domain/entities/answer.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/domain/repositories/trivia_repository.dart';
import 'package:smart_trivia/infrastructure/datasources/trivia_datasource_impl.dart';
import 'package:smart_trivia/infrastructure/repositories/trivia_repository_impl.dart';
import 'package:smart_trivia/presentation/providers/create_trivia_providers.dart';

final questionsProvider = StateNotifierProvider.autoDispose<QuestionsNotifier, List<Question>>((ref) {
  final questionsRepository = TriviaRepositoryImpl(datasource: TriviaDatasourceImpl());
  return QuestionsNotifier(questionsRepository: questionsRepository, ref: ref);
});


class QuestionsNotifier extends StateNotifier<List<Question>> {
  final TriviaRepository questionsRepository;
  bool isLoading = false;
  final StateNotifierProviderRef ref;

  QuestionsNotifier({required this.questionsRepository, required this.ref,  }) : super([]);

  Future<void> getQuestions() async {
    final List<Question> questions;
    String path = _getOptionsPath(ref);

    isLoading = true;

    questions = await questionsRepository.getQuestions(path);

    for(int i = 0; i < questions.length; i++ ) {
      questions[i].allAnswers = getAnswers(questions[i]);
    }
   
    isLoading = false;

    state = questions;
  }

  List<Answer> getAnswers(Question question) {
    List<Answer> answers = [];
    final random = Random();
    int randIndex = 0 + random.nextInt(question.incorrectAnswers.length - 0);
    int totalAnswers = question.incorrectAnswers.length + 1; // Las incorrectas mas la correcta
    int incorrectAnswerIndex = 0;

    for(int i = 0; i < totalAnswers; i++ ) {
      if(randIndex == i) {
        answers.add(Answer(answer: question.correctAnswer, isCorrect: true));
      } else {
        answers.add(Answer(answer: question.incorrectAnswers[incorrectAnswerIndex++], isCorrect: false));
      }
    }

    return answers;
  }

  String _getOptionsPath(StateNotifierProviderRef ref) {

    String path = '?amount=${ref.read(numQuestionsProvider.notifier).state}';

    if(ref.read(categoryProvider.notifier).state[''] != 'Any') {
      path = '$path&category=${ref.read(categorySelectedProvider.notifier).state}';
    }

    if(ref.read(difficultyProvider.notifier).state != 'Any') {
      path = '$path&difficulty=${ref.read(difficultyProvider.notifier).state}';
    }

    if(ref.read(typeProvider.notifier).state != 'Any') {
      path = '$path&type=${ref.read(typeProvider.notifier).state}';
    }

    return path;
  }
}