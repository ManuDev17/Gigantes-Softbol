import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //
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
  late int _juegos;
  late int _innings;
  late int _victorias;
  late int _derrotas;
  late int _juegoscerrados;
  late int _carreraspermitidas;
  late int _baseporbolas;
  late int _ponchesP;

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
    _juegos = widget.player?.juegos ?? 0;
    _juegoscerrados = widget.player?.juegoscerrados ?? 0;
    _innings = widget.player?.innings ?? 0;
    _victorias = widget.player?.victorias ?? 0;
    _derrotas = widget.player?.derrotas ?? 0;
    _ponchesP = widget.player?.ponchesP ?? 0;
    _baseporbolas = widget.player?.baseporbolas ?? 0;
    _carreraspermitidas = widget.player?.carreraspermitidas ?? 0;
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
              _buildNumberField('Juegos', _juegos, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese Juegos';
                }
                return null;
              }, (value) {
                _juegos = int.parse(value!);
              }),
              _buildNumberField('Juegos cerrados', _juegoscerrados, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese los juegos cerrados';
                }
                return null;
              }, (value) {
                _juegoscerrados = int.parse(value!);
              }),
              _buildNumberField('Innings', _innings, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese Innings';
                }
                return null;
              }, (value) {
                _innings = int.parse(value!);
              }),
              _buildNumberField('Victorias', _victorias, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese victorias';
                }
                return null;
              }, (value) {
                _victorias = int.parse(value!);
              }),
              _buildNumberField('Derrotas', _derrotas, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese derrotas';
                }
                return null;
              }, (value) {
                _derrotas = int.parse(value!);
              }),
              _buildNumberField('Ponches (Pitcheo)', _ponchesP, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese ponches';
                }
                return null;
              }, (value) {
                _ponchesP = int.parse(value!);
              }),
              _buildNumberField('Base por Bolas (Pitcheo)', _baseporbolas,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese base por bolas';
                }
                return null;
              }, (value) {
                _baseporbolas = int.parse(value!);
              }),
              _buildNumberField('Carreras Permitidas', _carreraspermitidas,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Carreras permitidas';
                }
                return null;
              }, (value) {
                _carreraspermitidas = int.parse(value!);
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Calcula el promedio de bateo, evitando la división por cero
                    double battingAverage =
                        (_atBats > 0) ? _hits / _atBats : 0.0;

                    double efectividad = (_innings > 0)
                        ? (_carreraspermitidas / _innings) * 7
                        : 0.0;

                    // Crea el objeto jugador con los datos ingresados
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
                      battingAverage: battingAverage,
                      efectividad: efectividad,
                      juegos: _juegos,
                      victorias: _victorias,
                      derrotas: _derrotas,
                      baseporbolas: _baseporbolas,
                      carreraspermitidas: _carreraspermitidas,
                      ponchesP: _ponchesP,
                      innings: _innings,
                      juegoscerrados:
                          _juegoscerrados, // Agrega el promedio de bateo
                    );

                    // Convierte los datos a un formato adecuado para Firestore
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
                      'battingAverage': player.battingAverage,
                      'efectividad': player.efectividad,
                      'juegos': player.juegos,
                      'victorias': player.victorias,
                      'derrotas': player.derrotas,
                      'baseporbolas': player.baseporbolas,
                      'carreraspermitidas': player.carreraspermitidas,
                      'ponchesP': player.ponchesP,
                      'innings': player.innings,
                      'juegos cerrados': player.juegoscerrados,
                    };

                    // Verifica si es una actualización o una creación nueva
                    try {
                      if (widget.player == null) {
                        await FirebaseFirestore.instance
                            .collection('players')
                            .add(playerData); // Agrega un nuevo jugador
                      } else {
                        await FirebaseFirestore.instance
                            .collection('players')
                            .doc(widget.player!.id)
                            .update(
                                playerData); // Actualiza el jugador existente
                      }

                      // Regresa a la pantalla anterior al guardar exitosamente
                      Navigator.of(context).pop(true);
                    } catch (e) {
                      // Si hay algún error, imprime el error y muestra un mensaje
                      print("Error al guardar jugador: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al guardar jugador: $e')),
                      );
                    }
                  }
                },
                child: const Text('Guardar'),
              )
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
