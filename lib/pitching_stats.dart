import 'package:flutter/material.dart';

class PitchingStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de Pitcheo'),
      ),
      body: Center(
        child: Text(
          'Aquí se mostrarán las estadísticas de pitcheo',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
