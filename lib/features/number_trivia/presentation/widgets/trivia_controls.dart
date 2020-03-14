import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';
import '../bloc/number_trivia_event.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController controller = TextEditingController();
  String inputStr = "";
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: ' Input a number'),
              onChanged: (value) {
                inputStr = value;
              },
              onSubmitted: (_) {
                dispatchConcrete();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      dispatchConcrete();
                    },
                    color: Theme.of(context).accentColor,
                    textTheme: ButtonTextTheme.primary,
                    child: const Text("Search",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RaisedButton(
                    textTheme: ButtonTextTheme.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      dispatchRandom();
                    },
                    child: const Text("Random", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumberEvent(inputStr));
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumberEvent());
  }
}
