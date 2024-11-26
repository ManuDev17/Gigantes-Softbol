import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:softbol/models/pitcher.dart';

class PitcherDetails extends StatefulWidget {
  final Pitcher? pitcher;

  const PitcherDetails({
    super.key,
    required this.pitcher,
  });

  @override
  _PitcherDetailsState createState() => _PitcherDetailsState();
}

class _PitcherDetailsState extends State<PitcherDetails> {
  late TextEditingController nameController;
  // Campos adicionales para las estadísticas de pitcheo
  late TextEditingController juegosController;
  late TextEditingController inningsController;
  late TextEditingController efectividadController;
  late TextEditingController victoriasController;
  late TextEditingController derrotasController;
  late TextEditingController ponchesPController;
  late TextEditingController baseporbolasPController;
  late TextEditingController carreraspermitidasController;
  late TextEditingController juegoscerradosController;

  // Instancia de Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores actuales del jugador
    nameController = TextEditingController(text: widget.pitcher?.name);

    // Inicializa los controladores con las estadísticas de pitcheo
    juegosController =
        TextEditingController(text: widget.pitcher?.juegos.toString() ?? '');
    inningsController =
        TextEditingController(text: widget.pitcher?.innings.toString() ?? '');
    efectividadController = TextEditingController(
        text: widget.pitcher?.efectividad.toString() ?? '');
    victoriasController =
        TextEditingController(text: widget.pitcher?.victorias.toString() ?? '');
    derrotasController =
        TextEditingController(text: widget.pitcher?.derrotas.toString() ?? '');
    ponchesPController =
        TextEditingController(text: widget.pitcher?.ponches.toString() ?? '');
    baseporbolasPController = TextEditingController(
        text: widget.pitcher?.baseporbolas.toString() ?? '');
    carreraspermitidasController = TextEditingController(
        text: widget.pitcher?.carreraspermitidas.toString() ?? '');
    juegoscerradosController = TextEditingController(
        text: widget.pitcher?.juegoscerrados.toString() ?? '');
  }

  @override
  void dispose() {
    // Limpia los controladores cuando la pantalla se cierre
    nameController.dispose();
    juegosController.dispose();
    inningsController.dispose();
    efectividadController.dispose();
    victoriasController.dispose();
    derrotasController.dispose();
    ponchesPController.dispose();
    baseporbolasPController.dispose();
    carreraspermitidasController.dispose();
    juegoscerradosController.dispose();
    super.dispose();
  }

  // Función para guardar los cambios
  Future<void> _saveChanges() async {
    final updatedPlayer = Pitcher(
      id: widget.pitcher?.id,
      name: nameController.text,
      number: widget.pitcher!.number, // El número no está editado aquí
      ponches: int.tryParse(ponchesPController.text) ?? widget.pitcher!.ponches,
      juegos: int.tryParse(juegosController.text) ?? widget.pitcher!.juegos,
      innings: int.tryParse(inningsController.text) ?? widget.pitcher!.innings,
      efectividad: double.tryParse(efectividadController.text) ??
          widget.pitcher!.efectividad,
      victorias:
          int.tryParse(victoriasController.text) ?? widget.pitcher!.victorias,
      derrotas:
          int.tryParse(derrotasController.text) ?? widget.pitcher!.derrotas,
      baseporbolas: int.tryParse(baseporbolasPController.text) ??
          widget.pitcher!.baseporbolas,
      carreraspermitidas: int.tryParse(carreraspermitidasController.text) ??
          widget.pitcher!.carreraspermitidas,
      juegoscerrados: int.tryParse(juegoscerradosController.text) ??
          widget.pitcher!.juegoscerrados,
    );

    // Asegúrate de que el ID del jugador no sea nulo
    if (widget.pitcher!.id != null) {
      await _firestore
          .collection('pitchers')
          .doc(widget.pitcher!.id!)
          .update(updatedPlayer.toMap());
    } else {
      // Maneja el caso de que el ID sea nulo
      print('Error: el ID es nulo, no se puede actualizar el pitcher.');
    }

    Navigator.pop(context); // Regresa a la pantalla anterior después de guardar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Estadísticas de ${widget.pitcher!.name}"),
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
                controller: ponchesPController,
                decoration: InputDecoration(labelText: 'Ponches'),
                keyboardType: TextInputType.number,
              ),
              // Sección de estadísticas de pitcheo
              TextFormField(
                controller: juegosController,
                decoration: InputDecoration(labelText: 'Juegos'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: inningsController,
                decoration: InputDecoration(labelText: 'Innings'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: efectividadController,
                decoration: InputDecoration(labelText: 'Efectividad'),
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
                controller: baseporbolasPController,
                decoration:
                    InputDecoration(labelText: 'Base por Bolas (Pitcheo)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: carreraspermitidasController,
                decoration: InputDecoration(labelText: 'Carreras Permitidas'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: juegoscerradosController,
                decoration: InputDecoration(labelText: 'Juegos Cerrados'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
