import 'package:flutter/material.dart';

import '../models/film.dart';

class DetailFilm extends StatelessWidget {
  final Film film;

  DetailFilm({required this.film});

  final String urlBaseAffiche = 'https://image.tmdb.org/t/p/w500/';
  final String imageParDefaut =
      'https://images.freeimages.com/images/large-previews/5eb/movieclapboard-1184339.jpg';

  @override
  Widget build(BuildContext context) {
    String chemin;
    if (film.urlAffiche != null && film.urlAffiche!.isNotEmpty) {
      chemin = urlBaseAffiche + film.urlAffiche!;
    } else {
      chemin = imageParDefaut;
    }

    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(film.titre ?? 'Détail du film'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: hauteur / 1.5,
                  child: Image.network(chemin, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  film.resume ?? 'Pas de description disponible.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
