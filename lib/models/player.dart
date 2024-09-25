import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 0) // Asignamos un id único para la clase Player
class Player extends HiveObject {
  @HiveField(0)
  int?
      id; // El id es nullable, lo que permite que sea null para nuevos jugadores

  @HiveField(1)
  String name;

  @HiveField(2)
  int number; // Número del jugador

  @HiveField(3)
  int hits;

  @HiveField(4)
  int atBats;

  @HiveField(5)
  int homeRuns;

  @HiveField(6)
  int RBIs;

  @HiveField(7)
  int stolenBases;

  @HiveField(8)
  int baseonballs;

  @HiveField(9)
  int ponches;

  @HiveField(10)
  int anotadas;

  Player({
    this.id, // El id ahora es opcional para jugadores nuevos
    required this.name,
    required this.number,
    required this.hits,
    required this.atBats,
    required this.homeRuns,
    required this.RBIs,
    required this.stolenBases,
    required this.baseonballs,
    required this.ponches,
    required this.anotadas,
  });

  // Getter para el average de bateo
  double get battingAverage {
    if (atBats == 0) {
      return 0;
    }
    return hits / atBats;
  }
}
