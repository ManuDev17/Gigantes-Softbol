import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Importa hive_flutter
import 'package:softbol/models/player.dart';

class HiveDatabase {
  static const String playerBoxName = 'playersBox';

  // Constructor privado para asegurar que no se pueda instanciar
  HiveDatabase._privateConstructor();

  static final HiveDatabase instance = HiveDatabase._privateConstructor();

  // Inicializar Hive y abrir la caja
  Future<void> init() async {
    await Hive.initFlutter(); // Aquí se inicializa Hive
    Hive.registerAdapter(
        PlayerAdapter()); // Asegúrate de tener el adaptador para Player
    await _openBox();
  }

  // Abrir la caja (box) de Hive donde almacenaremos los jugadores
  Future<Box<Player>> _openBox() async {
    return await Hive.openBox<Player>(playerBoxName);
  }

  // Insertar un jugador en la caja
  Future<void> insertPlayer(Player player) async {
    final box = await _openBox();
    await box.add(
        player); // add inserta automáticamente el objeto y le asigna una clave
  }

  // Actualizar un jugador en la caja
  Future<void> updatePlayer(int index, Player player) async {
    final box = await _openBox();
    await box.putAt(index, player); // Actualiza el jugador en el índice dado
  }

  // Eliminar un jugador de la caja
  Future<void> deletePlayer(int index) async {
    final box = await _openBox();
    await box.deleteAt(index); // Elimina el jugador en el índice dado
  }

  // Obtener la lista de todos los jugadores
  Future<List<Player>> getPlayers() async {
    final box = await _openBox();
    return box.values.toList(); // Devuelve todos los jugadores como una lista
  }

  // Cerrar la caja
  Future<void> closeBox() async {
    final box = await _openBox();
    await box.close(); // Cierra la caja cuando no sea necesario
  }
}
