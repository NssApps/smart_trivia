
import 'package:smart_trivia/domain/entities/answer.dart';

class Question {
    final String type;
    final String difficulty;
    final String category;
    final String question;
    final String correctAnswer;
    final List<String> incorrectAnswers;
    List<Answer>? allAnswers;

    Question({
        required this.type,
        required this.difficulty,
        required this.category,
        required this.question,
        required this.correctAnswer,
        required this.incorrectAnswers,
        this.allAnswers,
    });
}