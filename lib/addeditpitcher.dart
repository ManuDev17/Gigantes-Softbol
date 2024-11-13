import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:softbol/db/firestore_database.dart';
import 'package:softbol/models/pitcher.dart';

class AddEditPitcher extends StatefulWidget {
  final Pitcher? pitcher;

  const AddEditPitcher({Key? key, this.pitcher}) : super(key: key);

  @override
  _AddEditPitcherState createState() => _AddEditPitcherState();
}

class _AddEditPitcherState extends State<AddEditPitcher> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _number;
  late int _juegos;
  late int _innings;
  late double _efectividad;
  late int _victorias;
  late int _derrotas;
  late int _juegoscerrados;
  late int _carreraspermitidas;
  late int _baseporbolas;
  late int _ponches;

  @override
  void initState() {
    super.initState();
    _name = widget.pitcher?.name ?? '';
    _number = widget.pitcher?.number ?? 0;
    _juegos = widget.pitcher?.juegos ?? 0;
    _juegoscerrados = widget.pitcher?.juegoscerrados ?? 0;
    _innings = widget.pitcher?.innings ?? 0;
    _efectividad = widget.pitcher?.efectividad ?? 0;
    _victorias = widget.pitcher?.victorias ?? 0;
    _derrotas = widget.pitcher?.derrotas ?? 0;
    _ponches = widget.pitcher?.ponches ?? 0;
    _baseporbolas = widget.pitcher?.baseporbolas ?? 0;
    _carreraspermitidas = widget.pitcher?.carreraspermitidas ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.pitcher == null ? 'Añadir Jugador' : 'Editar Jugador'),
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
              _buildNumberField('Juegos', _juegos, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese los juegos';
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
              _buildNumberField('Ponches', _ponches, (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese ponches';
                }
                return null;
              }, (value) {
                _ponches = int.parse(value!);
              }),
              _buildNumberField('Base por Bolas', _baseporbolas, (value) {
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

                    // Calcula la efectividad:
                    _efectividad = (_innings > 0)
                        ? (_carreraspermitidas / _innings) * 9
                        : 0.0;

                    // Crea el objeto Pitcher con los datos ingresados
                    final pitcher = Pitcher(
                      id: widget.pitcher?.id,
                      name: _name,
                      number: _number,
                      efectividad: _efectividad,
                      juegos: _juegos,
                      victorias: _victorias,
                      derrotas: _derrotas,
                      baseporbolas: _baseporbolas,
                      carreraspermitidas: _carreraspermitidas,
                      ponches: _ponches,
                      innings: _innings,
                      juegoscerrados: _juegoscerrados,
                    );

                    // Convierte los datos a un formato adecuado para Firestore
                    final pitcherData = {
                      'name': pitcher.name,
                      'number': pitcher.number,
                      'efectividad': pitcher.efectividad,
                      'juegos': pitcher.juegos,
                      'victorias': pitcher.victorias,
                      'derrotas': pitcher.derrotas,
                      'baseporbolas': pitcher.baseporbolas,
                      'carreraspermitidas': pitcher.carreraspermitidas,
                      'ponches': pitcher.ponches,
                      'innings': pitcher.innings,
                      'juegos cerrados': pitcher.juegoscerrados,
                    };

                    // Verifica si es una actualización o una creación nueva
                    try {
                      if (widget.pitcher == null) {
                        await FirebaseFirestore.instance
                            .collection('pitcher')
                            .add(pitcherData); // Agrega un nuevo pitcher
                      } else {
                        await FirebaseFirestore.instance
                            .collection('pitcher')
                            .doc(widget.pitcher!.id)
                            .update(
                                pitcherData); // Actualiza el pitcher existente
                      }

                      // Regresa a la pantalla anterior al guardar exitosamente
                      Navigator.of(context).pop(true);
                    } catch (e) {
                      // Si hay algún error, imprime el error y muestra un mensaje
                      print("Error al guardar pitcher: $e");
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.white)),
      style: TextStyle(color: Colors.white),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
