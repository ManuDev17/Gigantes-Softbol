import 'package:flutter/material.dart';
import 'package:softbol/addeditpitcher.dart';

class PitchingStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Pitcheo'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Aquí se mostrarán las estadísticas de pitcheo',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega a AddEditPitcher cuando se presiona el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEditPitcher(),
                  ),
                );
              },
              child: const Text('Añadir/Editar Pitcher'),
            ),
          ],
        ),
      ),
    );
  }
}
