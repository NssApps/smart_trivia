
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/domain/entities/question.dart';

abstract class TriviaDatasource {
  Future<List<Question>> getQuestions(String path);
  Future<List<Category>> getCategories();
}