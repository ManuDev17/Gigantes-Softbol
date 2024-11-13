import 'package:cloud_firestore/cloud_firestore.dart';

class Pitcher {
  final String? id;
  final String name;
  final int number;
  final int innings;
  final double efectividad;
  final int victorias;
  final int derrotas;
  final int juegos;
  final int juegoscerrados;
  final int carreraspermitidas;
  final int baseporbolas;
  final int ponches;

  Pitcher({
    this.id,
    required this.name,
    required this.number,
    required this.innings,
    required this.efectividad,
    required this.victorias,
    required this.derrotas,
    required this.juegos,
    required this.juegoscerrados,
    required this.carreraspermitidas,
    required this.baseporbolas,
    required this.ponches,
  });

  // Método para crear un Player a partir de un documento Firestore
  factory Pitcher.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Pitcher(
      id: doc.id,
      name: data['name'] ?? '',
      number: data['number'] ?? 0,
      innings: data['innings'] ?? 0,
      efectividad: data['efectividad'] ?? 0,
      victorias: data['victorias'] ?? 0,
      derrotas: data['derrotas'] ?? 0,
      juegos: data['juegos'] ?? 0,
      juegoscerrados: data['juegoscerrados'] ?? 0,
      carreraspermitidas: data['carreraspermitidas'] ?? 0,
      baseporbolas: data['baseporbolas'] ?? 0,
      ponches: data['ponches'] ?? 0,
    );
  }

  // Método para convertir un Player a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'innings': innings,
      'efectividad': efectividad,
      'victorias': victorias,
      'derrotas': derrotas,
      'juegos': juegos,
      'juegoscerrados': juegoscerrados,
      'carreraspermitidas': carreraspermitidas,
      'baseporbolas': baseporbolas,
      'ponches': ponches,
    };
  }

  // Método para crear un Player a partir de un Map y un ID
  factory Pitcher.fromMap(Map<String, dynamic> data, String id) {
    return Pitcher(
      id: id,
      name: data['name'] ?? '',
      number: data['number'] ?? 0,
      innings: data['innings'] ?? 0,
      efectividad: data['efectividad'] ?? 0,
      victorias: data['victorias'] ?? 0,
      derrotas: data['derrotas'] ?? 0,
      juegos: data['juegos'] ?? 0,
      juegoscerrados: data['juegoscerrados'] ?? 0,
      carreraspermitidas: data['carreraspermitidas'] ?? 0,
      baseporbolas: data['baseporbolas'] ?? 0,
      ponches: data['ponches'] ?? 0,
    );
  }
}
