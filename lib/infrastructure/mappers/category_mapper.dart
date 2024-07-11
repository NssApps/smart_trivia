
import 'package:smart_trivia/domain/entities/category.dart';

class CategoryMapper {
  
  static Category categoryToEntity(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );
}