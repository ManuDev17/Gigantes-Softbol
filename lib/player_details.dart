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
  late TextEditingController juegosController;
  late TextEditingController juegoscerradosController;
  late TextEditingController inningsController;
  late TextEditingController victoriasController;
  late TextEditingController derrotasController;
  late TextEditingController ponchesPController;
  late TextEditingController baseporbolasController;
  late TextEditingController carreraspermitidasController;

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
    juegosController =
        TextEditingController(text: widget.player.juegos.toString());
    juegoscerradosController =
        TextEditingController(text: widget.player.juegoscerrados.toString());
    inningsController =
        TextEditingController(text: widget.player.innings.toString());
    victoriasController =
        TextEditingController(text: widget.player.victorias.toString());
    derrotasController =
        TextEditingController(text: widget.player.derrotas.toString());
    ponchesPController =
        TextEditingController(text: widget.player.ponchesP.toString());
    baseporbolasController =
        TextEditingController(text: widget.player.baseporbolas.toString());
    carreraspermitidasController = TextEditingController(
        text: widget.player.carreraspermitidas.toString());
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
    juegosController.dispose();
    juegoscerradosController.dispose();
    inningsController.dispose();
    victoriasController.dispose();
    derrotasController.dispose();
    ponchesPController.dispose();
    baseporbolasController.dispose();
    carreraspermitidasController.dispose();
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
      juegos: int.tryParse(juegosController.text) ?? widget.player.juegos,
      juegoscerrados: int.tryParse(juegoscerradosController.text) ??
          widget.player.juegoscerrados,
      innings: int.tryParse(inningsController.text) ?? widget.player.innings,
      victorias:
          int.tryParse(victoriasController.text) ?? widget.player.victorias,
      derrotas: int.tryParse(derrotasController.text) ?? widget.player.derrotas,
      ponchesP: int.tryParse(ponchesPController.text) ?? widget.player.ponchesP,
      baseporbolas: int.tryParse(baseporbolasController.text) ??
          widget.player.baseporbolas,
      carreraspermitidas: int.tryParse(carreraspermitidasController.text) ??
          widget.player.carreraspermitidas,
      efectividad: widget.player.efectividad,
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
              TextFormField(
                controller: juegosController,
                decoration: InputDecoration(labelText: 'Juegos'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: juegoscerradosController,
                decoration: InputDecoration(labelText: 'Juegos Cerrados'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: inningsController,
                decoration: InputDecoration(labelText: 'Innings'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: victoriasController,
                decoration: InputDecoration(labelText: 'Victorias'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: derrotasController,
                decoration: InputDecoration(labelText: 'Derrotas'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: ponchesPController,
                decoration: InputDecoration(labelText: 'Ponches (Pitcheo)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: baseporbolasController,
                decoration:
                    InputDecoration(labelText: 'Base por bolas (Pitcheo)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: carreraspermitidasController,
                decoration: InputDecoration(labelText: 'Carreras Permitidas'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
