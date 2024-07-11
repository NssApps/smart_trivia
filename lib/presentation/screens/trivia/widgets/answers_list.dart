

import 'package:flutter/material.dart';
import 'package:smart_trivia/domain/entities/answer.dart';
import 'package:smart_trivia/presentation/screens/trivia/widgets/answer_card.dart';

class AnswersList extends StatelessWidget {
  final List<Answer> answers;
  
  const AnswersList({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (context,index){
        final answer = answers[index];

        return AnswerCard(answer: answer, numAnswer: '${(index + 1)}',

        );
    });
  }
}