import 'package:flutter/material.dart';
import 'package:softbol/models/player.dart';
import 'package:softbol/db/firestore_database.dart';

class PlayerDetails extends StatefulWidget {
  final Player player;

  const PlayerDetails({
    super.key,
    required this.player,
  });

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  late TextEditingController nameController;
  late TextEditingController hitsController;
  late TextEditingController homeRunsController;
  late TextEditingController rbisController;
  late TextEditingController stolenBasesController;
  late TextEditingController baseonballsController;
  late TextEditingController ponchesController;
  late TextEditingController anotadasController;

  // Instancia de FirestoreDatabase
  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores actuales del jugador
    nameController = TextEditingController(text: widget.player.name);
    hitsController = TextEditingController(text: widget.player.hits.toString());
    homeRunsController =
        TextEditingController(text: widget.player.homeRuns.toString());
    rbisController = TextEditingController(text: widget.player.RBIs.toString());
    stolenBasesController =
        TextEditingController(text: widget.player.stolenBases.toString());
    baseonballsController =
        TextEditingController(text: widget.player.baseonballs.toString());
    ponchesController =
        TextEditingController(text: widget.player.ponches.toString());
    anotadasController =
        TextEditingController(text: widget.player.anotadas.toString());
  }

  @override
  void dispose() {
    // Limpia los controladores cuando la pantalla se cierre
    nameController.dispose();
    hitsController.dispose();
    homeRunsController.dispose();
    rbisController.dispose();
    stolenBasesController.dispose();
    baseonballsController.dispose();
    ponchesController.dispose();
    anotadasController.dispose();
    super.dispose();
  }

  // Función para guardar los cambios
  Future<void> _saveChanges() async {
    final updatedPlayer = Player(
      id: widget.player.id,
      name: nameController.text,
      number: widget.player.number, // El número no está editado aquí
      hits: int.tryParse(hitsController.text) ?? widget.player.hits,
      atBats: widget.player.atBats, // Puedes agregar atBats si lo deseas
      homeRuns: int.tryParse(homeRunsController.text) ?? widget.player.homeRuns,
      RBIs: int.tryParse(rbisController.text) ?? widget.player.RBIs,
      stolenBases:
          int.tryParse(stolenBasesController.text) ?? widget.player.stolenBases,
      baseonballs:
          int.tryParse(baseonballsController.text) ?? widget.player.baseonballs,
      ponches: int.tryParse(ponchesController.text) ?? widget.player.ponches,
      anotadas: int.tryParse(anotadasController.text) ?? widget.player.anotadas,
      battingAverage: widget.player.battingAverage, // Incluye este campo
    );

    // Asegúrate de que el ID del jugador no sea nulo
    if (widget.player.id != null) {
      await firestoreDatabase.updatePlayer(widget.player.id!, updatedPlayer);
    } else {
      // Maneja el caso de que el ID sea nulo
      print('Error: el ID es nulo, no se puede actualizar el jugador.');
    }

    Navigator.pop(context); // Regresa a la pantalla anterior después de guardar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Estadísticas de ${widget.player.name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges, // Guarda los cambios
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: hitsController,
                decoration: InputDecoration(labelText: 'Hits'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: homeRunsController,
                decoration: InputDecoration(labelText: 'Home Runs'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: rbisController,
                decoration:
                    InputDecoration(labelText: 'RBIs (Carreras Impulsadas)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: stolenBasesController,
                decoration: InputDecoration(labelText: 'Bases Robadas'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: baseonballsController,
                decoration: InputDecoration(labelText: 'Base por Bolas'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: ponchesController,
                decoration: InputDecoration(labelText: 'Ponches'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: anotadasController,
                decoration: InputDecoration(labelText: 'R (Carreras Anotadas)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
