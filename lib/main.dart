import 'package:flutter/material.dart';
import 'pages/movie_list.dart';

//TODO: Implementação de Temas?

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlideWorks',
      theme: ThemeData(primarySwatch: Colors.blue),

      home: const Movielist(),

      routes: {
        '/movie_list': (context) => Movielist(),
      },
    );
  }
}
