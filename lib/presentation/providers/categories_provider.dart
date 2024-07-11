import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/domain/repositories/trivia_repository.dart';
import 'package:smart_trivia/infrastructure/datasources/trivia_datasource_impl.dart';
import 'package:smart_trivia/infrastructure/repositories/trivia_repository_impl.dart';

final categoriesProvider = StateNotifierProvider.autoDispose<CategoriesNotifier, List<Category>>((ref) {
  final questionsRepository = TriviaRepositoryImpl(datasource: TriviaDatasourceImpl());
  return CategoriesNotifier(questionsRepository: questionsRepository);
});

class CategoriesNotifier extends StateNotifier<List<Category>> {
  final TriviaRepository questionsRepository;
  bool isLoading = false;

  CategoriesNotifier({required this.questionsRepository,  }) : super([]);

  Future<void> getCategories() async {
    final List<Category> categories;
    categories = await questionsRepository.getCategories();
    state = categories;
  }

}