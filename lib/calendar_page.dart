import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calendario LISU 2024',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Imagen de fondo optimizada
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondonegroo.png',
              fit: BoxFit.cover,
              gaplessPlayback: true, // Mejora el rendimiento en cambios rápidos
            ),
          ),
          // Contenido principal
          ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              // Partidos con Box Score
              _buildMatchWithBoxScore(
                'Carboneros Vs Gigantes de Montevideo',
                '8 de Septiembre, Estadio Charrua',
                'Resultado Carboneros 9 - Gigantes 2 , Gigantes fue local',
                {
                  '1er inning': '0 carreras ambos',
                  '2do inning': '1 carrera Carboneros',
                  '3er inning': '1 carrera Carboneros',
                  '4to inning': '4 carreras Carboneros, 1 carrera Gigantes',
                  '5to inning': '0 carreras ambos',
                  '6to inning': '3 carreras Carboneros, 1 carrera Gigantes',
                },
              ),
              _buildMatchWithBoxScore(
                'Gigantes de Montevideo Vs Repecho',
                '15 de septiembre, 12.00pm, Estadio Nuevo Parque Rivera',
                'Resultado Repecho 22 - Gigantes 11 , Gigantes fue local',
                {
                  '1er inning': '4 carreras ambos',
                  '2do inning': '8 carreras Repecho, 1 carrera Gigantes',
                  '3er inning': '1 carrera Repecho, 2 carreras Gigantes',
                  '4to inning': '1 carrera Repecho',
                  '5to inning': '0 carreras Repecho, 4 carreras Gigantes',
                  '6to inning': '8 carreras Repecho, 4 carreras Gigantes',
                },
              ),
              _buildMatch(
                'Pa Goza Vs Gigantes de Montevideo',
                '22 de septiembre, 9.45am, Estadio Colón',
              ),
              _buildMatch(
                '29 de septiembre',
                'Jornada Libre',
              ),
              _buildMatch(
                'Cerveceros Vs Gigantes de Montevideo',
                '6 de octubre, 12.00pm, Estadio Nuevo Parque Rivera',
              ),
              _buildMatch(
                'Gigantes de Montevideo Vs Vegueros',
                '13 de octubre, 9.45am, Estadio Charrua',
              ),
              _buildMatch(
                'Mets Vs Gigantes de Montevideo',
                '20 de octubre, 12.00pm, Estadio Nuevo Parque Rivera',
              ),
              _buildMatch(
                'Gigantes de Montevideo Vs Cuba Libre',
                '27 de octubre, 9.45am, Estadio Colon',
              ),
              _buildMatch(
                '3 de noviembre',
                'Jornada Libre',
              ),
            ],
          ),
        ],
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
          currentIndex: 1, // Índice del Calendario
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/calendar');
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, '/standings');
            }
          }),
    );
  }

  // Método para construir la información de un partido
  Widget _buildMatch(String title, String date) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      subtitle: Text(
        date,
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
      onTap: () {
        // Funcionalidad futura
      },
    );
  }

  // Método para construir un partido con box score
  Widget _buildMatchWithBoxScore(
      String title, String date, String result, Map<String, String> boxScore) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      subtitle: Text(
        date,
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result,
                style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
              ),
              SizedBox(height: 8),
              for (var entry in boxScore.entries)
                Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
