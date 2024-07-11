


import 'package:flutter/material.dart';
import 'package:smart_trivia/domain/entities/question.dart';
import 'package:html/parser.dart';

class QuestionContainer extends StatelessWidget {
  final Question question;

  const QuestionContainer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {

    String parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString = parse(document.body!.text).documentElement!.text;
      return parsedString;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Category: ', 
                style: TextStyle(
                  color: Color(0xFFB063C0),
                  fontWeight: FontWeight.bold
                ),
              ),

              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(question.category),
              )),
              
            ],
          ),

          const SizedBox(height: 5,),

          Text(parseHtmlString(question.question),
            style: const TextStyle(fontSize: 18),
          )
        ],
      )
    );
  }
}



