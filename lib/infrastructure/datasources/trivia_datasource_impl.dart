
import 'package:dio/dio.dart';
import 'package:smart_trivia/config/constants/environment.dart';
import 'package:smart_trivia/domain/datasources/trivia_datasource.dart';
import 'package:smart_trivia/domain/entities/category.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/infrastructure/errors/custom_error.dart';
import 'package:smart_trivia/infrastructure/models/category_model.dart';
import 'package:smart_trivia/infrastructure/models/trivia_response_model.dart';

class TriviaDatasourceImpl extends TriviaDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl
  ));

  @override
  Future<List<Question>> getQuestions(String path) async {
    try {
      final response = await dio.get('/api.php$path',  options: Options(headers: {
          "Content-Type": "application/json",
          // "Authorization":
          //     "Bearer $token",
        }));

      if(response.statusCode == 200) {
        final triviaResponse = TriviaResponse.fromJson(response.data);
        final List<Question> questions = triviaResponse.results;
      
        return questions;
      }

      return [];

      // throw Exception();

    } on DioException catch(e) {
      // print(e.response?.statusCode);
      // print(e.response?.data['message']);
      if(e.response?.statusCode == 403) {
        throw CustomError(errorMessage:  e.response?.data['message'] ?? 'Credenciales inválidas');
      }

      if(e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(errorMessage: 'Connection Timeout');
      }

      if(e.response?.statusCode == 302) {
        throw CustomError(errorMessage: 'Unprocessable Content');
      }

      throw Exception();
    } catch(e) {
      throw Exception();
    } 
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get('/api_category.php',  options: Options(headers: {
          "Content-Type": "application/json",
          // "Authorization":
          //     "Bearer $token",
        }));

      if(response.statusCode == 200) {
        final categoryResponse = CategoryResponse.fromJson(response.data);
        final List<Category> categories = categoryResponse.triviaCategories;

        // print(response.data['trivia_categories']);
      
        return categories;
      }

      return [];

      // throw Exception();

    } on DioException catch(e) {
      // print(e.response?.statusCode);
      // print(e.response?.data['message']);
      if(e.response?.statusCode == 403) {
        throw CustomError(errorMessage:  e.response?.data['message'] ?? 'Credenciales inválidas');
      }

      if(e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(errorMessage: 'Connection Timeout');
      }

      if(e.response?.statusCode == 302) {
        throw CustomError(errorMessage: 'Unprocessable Content');
      }

      throw Exception();
    } catch(e) {
      throw Exception();
    } 
  }

}