import 'package:flutter/material.dart';
import 'addeditplayer.dart';
import 'package:softbol/models/player.dart'; // Asegúrate de importar el modelo del jugador

class PlayerListScreen extends StatelessWidget {
  final List<Player> players; // Esta lista contiene los jugadores

  PlayerListScreen({required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jugadores'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPlayer(
                      player: player), // Pasa el jugador seleccionado
                ),
              );
            },
            child: ListTile(
              title: Text(player.name),
              subtitle: Text('Número: ${player.number}'),
            ),
          );
        },
      ),
    );
  }
}
