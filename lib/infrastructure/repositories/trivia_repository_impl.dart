

import 'package:smart_trivia/domain/datasources/trivia_datasource.dart';
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl extends TriviaRepository {
  final TriviaDatasource datasource;

  TriviaRepositoryImpl({required this.datasource});

  @override
  Future<List<Question>> getQuestions(String path) {
    return datasource.getQuestions(path);
  }

  @override
  Future<List<Category>> getCategories() {
    return datasource.getCategories();
  }

}