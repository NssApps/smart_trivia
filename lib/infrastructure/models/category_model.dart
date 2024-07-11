
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/infrastructure/mappers/category_mapper.dart';

class CategoryResponse {
    final List<Category> triviaCategories;

    CategoryResponse({
        required this.triviaCategories,
    });

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        triviaCategories: List<Category>.from(json["trivia_categories"].map((x) => CategoryMapper.categoryToEntity(x)   )),
    );

  
}


