import 'package:allons_au_cinema/models/film.dart';
import 'package:flutter/material.dart';
import '../http/http_helper.dart';
import 'detail_film.dart';

class ListeFilms extends StatefulWidget {
  const ListeFilms({super.key});

  @override
  State<ListeFilms> createState() => _ListeFilmsState();
}
class _ListeFilmsState extends State<ListeFilms> {
  List films = [];
  int nombreDeFilms = 0;
  HttpHelper? helper;

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String imageParDefaut =
      'https://images.freeimages.com/images/large-previews/5eb/movieclapboard-1184339.jpg';

  Icon iconVisible = const Icon(Icons.search);
  Widget barreRecherche = const Text('Films');
  bool inverserTri = false;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialiser();
  }

  Future<void> initialiser() async {
    films = await helper!.recevoirNouveauxFilms();
    setState(() {
      nombreDeFilms = films.length;
    });
  }

  Future<void> rechercher(String texte) async {
    films = await helper!.rechercherFilms(texte);
    setState(() {
      nombreDeFilms = films.length;
    });
  }

  // Tri basé sur la note des films
  void trier(bool inverser) {
    films.sort(); // Trie les films par note (comparable)
    if (inverser) {
      films = films.reversed.toList(); // Inverse l'ordre du tri
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: barreRecherche,
        actions: <Widget>[
          IconButton(
            icon: iconVisible,
            onPressed: () {
              setState(() {
                if (iconVisible.icon == Icons.search) {
                  iconVisible = const Icon(Icons.cancel);
                  barreRecherche = TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                    onSubmitted: (String texte) {
                      rechercher(texte);
                    },
                  );
                } else {
                  iconVisible = const Icon(Icons.search);
                  barreRecherche = const Text('Films');
                  initialiser();
                }
              });
            },
          ),
          IconButton( // Bouton pour trier par note
            icon: const Icon(Icons.sort),
            onPressed: () {
              inverserTri = !inverserTri; // Inverser l'état à chaque clic
              trier(inverserTri);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: (this.nombreDeFilms == null) ? 0 : this.nombreDeFilms,
        itemBuilder: (context, position) {
          Film film = films[position];
          if (film.urlAffiche != null && film.urlAffiche!.isNotEmpty) {
            image = NetworkImage(iconBase + film.urlAffiche!);
          } else {
            image = NetworkImage(imageParDefaut);
          }

          return Card(
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(film.titre ?? ''),
              subtitle: Text(
                'Note : ${film.note?.toStringAsFixed(1) ?? 'N/A'}\nSortie : ${film.dateDeSortie ?? 'inconnue'}',
              ),
              isThreeLine: true,
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => DetailFilm(film: film),
                );
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}