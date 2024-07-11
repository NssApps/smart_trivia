

import 'package:smart_trivia/domain/entities/question.dart';
import 'package:smart_trivia/infrastructure/mappers/question_mapper.dart';

class TriviaResponse {
    final int responseCode;
    final List<Question> results;

    TriviaResponse({
        required this.responseCode,
        required this.results,
    });

    factory TriviaResponse.fromJson(Map<String, dynamic> json) => TriviaResponse(
        responseCode: json["response_code"],
        results: List<Question>.from(json["results"].map((x) => QuestionMapper.questionToEntity(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "response_code": responseCode,
    //     "results": List<dynamic>.from(results.map((x) => x.toJson())),
    // };
}

