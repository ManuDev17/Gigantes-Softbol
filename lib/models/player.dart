import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String? id;
  final String name;
  final int number;
  final int hits;
  final double battingAverage;
  final int homeRuns;
  final int RBIs;
  final int stolenBases;
  final int baseonballs;
  final int atBats;
  final int ponches;
  final int anotadas;

  Player({
    this.id,
    required this.name,
    required this.number,
    required this.hits,
    required this.battingAverage,
    required this.homeRuns,
    required this.RBIs,
    required this.stolenBases,
    required this.baseonballs,
    required this.atBats,
    required this.ponches,
    required this.anotadas,
  });

  // Método para crear un Player a partir de un documento Firestore
  factory Player.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Player(
      id: doc.id,
      name: data['name'] ?? '',
      number: data['number'] ?? 0,
      hits: data['hits'] ?? 0,
      battingAverage: (data['battingAverage'] ?? 0.0).toDouble(),
      homeRuns: data['homeRuns'] ?? 0,
      RBIs: data['RBIs'] ?? 0,
      stolenBases: data['stolenBases'] ?? 0,
      baseonballs: data['baseonballs'] ?? 0,
      atBats: data['atBats'] ?? 0,
      ponches: data['ponches'] ?? 0,
      anotadas: data['anotadas'] ?? 0,
    );
  }

  // Método para convertir un Player a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'hits': hits,
      'battingAverage': battingAverage,
      'homeRuns': homeRuns,
      'RBIs': RBIs,
      'stolenBases': stolenBases,
      'baseonballs': baseonballs,
      'atBats': atBats,
      'ponches': ponches,
      'anotadas': anotadas,
    };
  }

  // Método para crear un Player a partir de un Map y un ID
  factory Player.fromMap(Map<String, dynamic> data, String id) {
    return Player(
      id: id,
      name: data['name'] ?? '',
      number: data['number'] ?? 0,
      hits: data['hits'] ?? 0,
      battingAverage: (data['battingAverage'] ?? 0.0).toDouble(),
      homeRuns: data['homeRuns'] ?? 0,
      RBIs: data['RBIs'] ?? 0,
      stolenBases: data['stolenBases'] ?? 0,
      baseonballs: data['baseonballs'] ?? 0,
      atBats: data['atBats'] ?? 0,
      ponches: data['ponches'] ?? 0,
      anotadas: data['anotadas'] ?? 0,
    );
  }
}
