import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:softbol/models/player.dart';
import 'addeditplayer.dart'; // Pantalla para agregar/editar jugadores
import 'torneo_de_plata_2024.dart'; // Importa la nueva pantalla

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Player>> _players;
  int _selectedIndex = 0; // Para controlar el BottomNavigationBar
  final String correctPassword = "0953"; // Define la contraseña aquí

  @override
  void initState() {
    super.initState();
    _refreshPlayers();
  }

  // Cargar jugadores desde Firestore
  Future<List<Player>> _fetchPlayers() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('players').get();
    return snapshot.docs.map((doc) => Player.fromFirestore(doc)).toList();
  }

  void _refreshPlayers() {
    setState(() {
      _players = _fetchPlayers(); // Actualiza la lista de jugadores
    });
  }

  Future<void> _deletePlayer(String? playerId) async {
    if (playerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: El ID del jugador es nulo.')),
      );
      return;
    }

    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Jugador'),
        content: Text('¿Estás seguro de que deseas eliminar a este jugador?'),
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
      await FirebaseFirestore.instance
          .collection('players')
          .doc(playerId)
          .delete();
      _refreshPlayers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jugador eliminado')),
      );
    }
  }

  Future<bool> _showPasswordDialog(BuildContext context) async {
    final _passwordController = TextEditingController();
    bool _isPasswordVisible = false;

    final bool? passwordAccepted = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Ingrese la contraseña'),
              content: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (_passwordController.text == correctPassword) {
                      Navigator.of(context).pop(true); // Contraseña correcta
                    } else {
                      Navigator.of(context).pop(false); // Contraseña incorrecta
                    }
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      },
    );

    return passwordAccepted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Gigantes de Montevideo',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TorneoDePlata2024(),
                ),
              );
            },
          ),
        ],
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
                        bool passwordCorrect =
                            await _showPasswordDialog(context);

                        if (!passwordCorrect) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Contraseña incorrecta')),
                          );
                          return false;
                        }

                        if (direction == DismissDirection.startToEnd) {
                          // Eliminar jugador
                          await _deletePlayer(player.id);
                          return false;
                        } else if (direction == DismissDirection.endToStart) {
                          // Editar jugador
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
          bool passwordCorrect = await _showPasswordDialog(context);

          if (passwordCorrect) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditPlayer(),
              ),
            );
            if (result == true) {
              _refreshPlayers(); // Refresca la lista de jugadores
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Contraseña incorrecta')),
            );
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
        currentIndex: _selectedIndex, // Usa el índice seleccionado
        onTap: (int index) {
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });

            // Navegar a las diferentes pantallas según el índice
            if (_selectedIndex == 1) {
              Navigator.popAndPushNamed(
                  context, '/calendar'); // Ir a Calendario
            } else if (_selectedIndex == 2) {
              Navigator.popAndPushNamed(
                  context, '/standings'); // Ir a Posiciones
            }
          }
        },
      ),
    );
  }
}
