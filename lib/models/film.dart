class Film implements Comparable {
  int? id;
  String? titre;
  double? note;
  String? dateDeSortie;
  String? resume;
  String? urlAffiche;

  Film({
    this.id,
    this.titre,
    this.note,
    this.dateDeSortie,
    this.resume,
    this.urlAffiche,
  });

  Film.fromJson(Map<String, dynamic> chaineJson) {
    id = chaineJson['id'];
    titre = chaineJson['title'];
    note = (chaineJson['vote_average'] ?? 0).toDouble();
    dateDeSortie = chaineJson['release_date'];
    resume = chaineJson['overview'];
    urlAffiche = chaineJson['poster_path'];
  }

  String get afficheURL {
    return urlAffiche != null
        ? 'https://image.tmdb.org/t/p/w500$urlAffiche'
        : '';
  }

  @override
  int compareTo(other)
  {
    if (note == null || other == null) {
      return 0;
    }
    if (note! < other.note) {
      return 1;
    }
    if (note! > other.note) {
      return -1;
    }
    return 0;
  }
}
