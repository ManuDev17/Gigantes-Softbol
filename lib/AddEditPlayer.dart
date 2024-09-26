import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Asegúrate de incluir esta línea
//import 'package:softbol/db/firestore_database.dart';
import 'package:softbol/models/player.dart';

class AddEditPlayer extends StatefulWidget {
  final Player? player;

  const AddEditPlayer({Key? key, this.player}) : super(key: key);

  @override
  _AddEditPlayerState createState() => _AddEditPlayerState();
}

class _AddEditPlayerState extends State<AddEditPlayer> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _number;
  late int _hits;
  late int _atBats;
  late int _homeRuns;
  late int _RBIs;
  late int _stolenBases;
  late int _baseonballs;
  late int _ponches;
  late int _anotadas;

  @override
  void initState() {
    super.initState();
    _name = widget.player?.name ?? '';
    _number = widget.player?.number ?? 0;
    _hits = widget.player?.hits ?? 0;
    _atBats = widget.player?.atBats ?? 0;
    _homeRuns = widget.player?.homeRuns ?? 0;
    _RBIs = widget.player?.RBIs ?? 0;
    _stolenBases = widget.player?.stolenBases ?? 0;
    _baseonballs = widget.player?.baseonballs ?? 0;
    _ponches = widget.player?.ponches ?? 0;
    _anotadas = widget.player?.anotadas ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.player == null ? 'Añadir Jugador' : 'Editar Jugador'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField('Nombre', _name, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el nombre';
                }
                return null;
              }, (value) {
                _name = value!;
              }),
              _buildNumberField('Número', _number, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el número';
                }
                return null;
              }, (value) {
                _number = int.parse(value!);
              }),
              _buildNumberField('Hits', _hits, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese los hits';
                }
                return null;
              }, (value) {
                _hits = int.parse(value!);
              }),
              _buildNumberField('Oportunidades al bate', _atBats, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese oportunidades al bate';
                }
                return null;
              }, (value) {
                _atBats = int.parse(value!);
              }),
              _buildNumberField('Home Runs', _homeRuns, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese home runs';
                }
                return null;
              }, (value) {
                _homeRuns = int.parse(value!);
              }),
              _buildNumberField('RBIs (Carreras Impulsadas)', _RBIs, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese RBIs';
                }
                return null;
              }, (value) {
                _RBIs = int.parse(value!);
              }),
              _buildNumberField('Bases Robadas', _stolenBases, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese bases robadas';
                }
                return null;
              }, (value) {
                _stolenBases = int.parse(value!);
              }),
              _buildNumberField('Base por bolas', _baseonballs, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese base por bolas';
                }
                return null;
              }, (value) {
                _baseonballs = int.parse(value!);
              }),
              _buildNumberField('Ponches', _ponches, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese ponches';
                }
                return null;
              }, (value) {
                _ponches = int.parse(value!);
              }),
              _buildNumberField('Carreras Anotadas', _anotadas, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese carreras anotadas';
                }
                return null;
              }, (value) {
                _anotadas = int.parse(value!);
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Calcula el promedio de bateo, evitando la división por cero
                    double battingAverage =
                        (_atBats > 0) ? _hits / _atBats : 0.0;

                    final player = Player(
                      id: widget.player?.id,
                      name: _name,
                      number: _number,
                      hits: _hits,
                      atBats: _atBats,
                      homeRuns: _homeRuns,
                      RBIs: _RBIs,
                      stolenBases: _stolenBases,
                      baseonballs: _baseonballs,
                      ponches: _ponches,
                      anotadas: _anotadas,
                      battingAverage:
                          battingAverage, // Agrega el promedio de bateo
                    );

                    final playerData = {
                      'name': player.name,
                      'number': player.number,
                      'hits': player.hits,
                      'atBats': player.atBats,
                      'homeRuns': player.homeRuns,
                      'RBIs': player.RBIs,
                      'stolenBases': player.stolenBases,
                      'baseonballs': player.baseonballs,
                      'ponches': player.ponches,
                      'anotadas': player.anotadas,
                      'battingAverage':
                          player.battingAverage, // Agrega el promedio de bateo
                    };

                    if (widget.player == null) {
                      await FirebaseFirestore.instance
                          .collection('players')
                          .add(playerData);
                    } else {
                      await FirebaseFirestore.instance
                          .collection('players')
                          .doc(widget.player!.id)
                          .update(playerData);
                    }

                    Navigator.of(context).pop(true);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue,
      String? Function(String?) validator, void Function(String?) onSaved) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.white)),
      style: TextStyle(color: Colors.white),
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildNumberField(String label, int initialValue,
      String? Function(String?) validator, void Function(String?) onSaved) {
    return TextFormField(
      initialValue: initialValue.toString(),
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.white)),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
