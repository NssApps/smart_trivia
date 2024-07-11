
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/domain/entities/question.dart';

abstract class TriviaRepository {
  Future<List<Question>> getQuestions(String path);
  Future<List<Category>> getCategories();
}