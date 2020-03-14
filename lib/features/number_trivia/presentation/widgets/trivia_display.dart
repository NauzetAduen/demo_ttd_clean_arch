import 'package:demo_tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;
  const TriviaDisplay({
    Key key,
    @required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          trivia.number.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Center(
            child: SingleChildScrollView(
          child: Text(
            trivia.text,
            style: const TextStyle(
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
        )),
      ],
    );
  }
}
