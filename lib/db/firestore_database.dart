import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softbol/models/player.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'players'; // Colección de jugadores

  // Agrega un nuevo jugador
  Future<void> addPlayer(Player player) async {
    try {
      await _firestore.collection(collectionPath).add(player.toMap());
    } catch (e) {
      print("Error al agregar jugador: $e");
    }
  }

  // Obtiene un jugador por ID
  Future<Player?> getPlayerById(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection(collectionPath).doc(id).get();
      if (docSnapshot.exists) {
        return Player.fromMap(docSnapshot.data()!, id);
      }
    } catch (e) {
      print("Error al obtener jugador: $e");
    }
    return null;
  }

  // Actualiza un jugador existente
  Future<void> updatePlayer(String id, Player updatedPlayer) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(id)
          .update(updatedPlayer.toMap());
    } catch (e) {
      print("Error al actualizar jugador: $e");
    }
  }

  // Elimina un jugador por ID
  Future<void> deletePlayer(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      print("Error al eliminar jugador: $e");
    }
  }

  // Obtiene todos los jugadores
  Stream<List<Player>> getPlayers() {
    return _firestore.collection(collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Player.fromMap(
            doc.data(), doc.id); // Cambiado para incluir el ID
      }).toList();
    });
  }
}
