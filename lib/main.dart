import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDD - Clean Arch',
      theme: ThemeData(
        primaryColor: Colors.indigo.shade400,
        accentColor: Colors.indigo.shade800,
      ),
      home: NumberTriviaPage(),
    );
  }
}
