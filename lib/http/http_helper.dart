import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/film.dart';

class HttpHelper {
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlCmd = '/upcoming?';
  final String urlRecherche = 'https://api.themoviedb.org/3/search/movie?';
  final String urlKey = 'api_key=c70ea3c2f8dccc5c78bee29192c9a476';
  final String urlLangage = '&language=fr-FR';


  Future<List<Film>> recevoirNouveauxFilms() async {
    final urlNouveauxFilms = '$urlBase$urlCmd$urlKey$urlLangage';
    http.Response resultat = await http.get(Uri.parse(urlNouveauxFilms));

    if (resultat.statusCode == HttpStatus.ok) {
      final chaineJson = json.decode(resultat.body);
      final filmsMap = chaineJson['results'];
      List<Film> films = filmsMap.map<Film>((json) => Film.fromJson(json)).toList();
      return films;
    } else {
      return [];
    }
  }

  Future<List> rechercherFilms(String titre) async {
    var url = '$urlRecherche$urlKey$urlLangage&query=';

    final String query = url + titre;
    http.Response resultat = await http.get(Uri.parse(query));
    if (resultat.statusCode == HttpStatus.ok) {
      final reponseJson = json.decode(resultat.body);
      final filmsMap = reponseJson['results'];
      List films = filmsMap.map((i) => Film.fromJson(i)).toList();
      return films;
    } else {
      print(resultat.statusCode);
      return [];
    }
  }
}
