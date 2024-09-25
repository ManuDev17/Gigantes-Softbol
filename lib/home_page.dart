import 'package:flutter/material.dart';
import 'package:softbol/calendar_page.dart';
import 'package:softbol/standings_page.dart';
import 'package:softbol/models/player.dart';
import 'package:softbol/db/hive_database.dart';
import 'addeditplayer.dart'; // Pantalla para agregar/editar jugadores

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Player>> _players;
  int _selectedIndex = 0; // Para controlar el BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _refreshPlayers();
  }

  void _refreshPlayers() {
    setState(() {
      _players = HiveDatabase.instance.getPlayers();
    });
  }

  Future<void> _deletePlayer(Player player) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Jugador'),
        content: Text('¿Estás seguro de que deseas eliminar a ${player.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancelar
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Confirmar
            child: Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      await HiveDatabase.instance.deletePlayer(player.id!);
      _refreshPlayers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jugador ${player.name} eliminado')),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      // Navegar a las diferentes pantallas según el índice
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Volver a Home
        );
      } else if (_selectedIndex == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage()), // Calendario
        );
      } else if (_selectedIndex == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StandingsPage()), // Tabla de posiciones
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Gigantes de Montevideo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondonegroo.png',
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder<List<Player>>(
            future: _players,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child:
                        Text('Error al cargar jugadores: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.isEmpty) {
                return Center(child: Text('No se encuentran jugadores.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final player = snapshot.data![index];
                    return Dismissible(
                      key: ValueKey(player.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blue,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          await _deletePlayer(player);
                          return false;
                        } else if (direction == DismissDirection.endToStart) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditPlayer(player: player),
                            ),
                          );
                          if (result == true) {
                            _refreshPlayers();
                          }
                          return false;
                        }
                        return false;
                      },
                      child: ExpansionTile(
                        title: Text(
                          player.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Número: ${player.number}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hits: ${player.hits}',
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                    'Average de Bateo: ${player.battingAverage.toStringAsFixed(3)}',
                                    style: TextStyle(color: Colors.white)),
                                Text('Home Runs: ${player.homeRuns}',
                                    style: TextStyle(color: Colors.white)),
                                Text('RBIs Carreras Impulsadas: ${player.RBIs}',
                                    style: TextStyle(color: Colors.white)),
                                Text('Bases Robadas: ${player.stolenBases}',
                                    style: TextStyle(color: Colors.white)),
                                Text('Base por Bolas: ${player.baseonballs}',
                                    style: TextStyle(color: Colors.white)),
                                Text('Oportunidades al bate: ${player.atBats}',
                                    style: TextStyle(color: Colors.white)),
                                Text('Ponches: ${player.ponches}',
                                    style: TextStyle(color: Colors.white)),
                                Text('R Carreras Anotadas: ${player.anotadas}',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPlayer(),
            ),
          );
          if (result == true) {
            _refreshPlayers(); // Refresca la lista de jugadores
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Posiciones',
            ),
          ],
          currentIndex: 0, // Índice del Home
          onTap: (int index) {
            switch (index) {
              case 0:
                break; // Ya estás en el Home
              case 1:
                Navigator.popAndPushNamed(
                    context, '/calendar'); // Regresar a la página principal
                break;

              case 2:
                Navigator.popAndPushNamed(
                    context, '/standings'); // Ir a la tabla de posiciones
                break;
            }
          }),
    );
  }
}
