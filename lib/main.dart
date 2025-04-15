import 'package:flutter/material.dart';
import 'pages/liste_films.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films TMDb',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListeFilms(),
    );
  }
}
