
import 'package:smart_trivia/domain/entities/question.dart';

class QuestionMapper {
  
  static Question questionToEntity(Map<String, dynamic> json) => Question(
        type: json["type"],
        difficulty: json["difficulty"],
        category: json["category"],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
    );
}