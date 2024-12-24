import 'package:flutter/material.dart';

class Calendariotorneodeplata2024 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calendario Torneo de Plata 2024',
            style: TextStyle(
              fontSize: 20,
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
                'Gigantes de Montevideo vs La Costa',
                '17 de Noviembre 2.00 pm, Estadio Charrua',
                'Resultado Gigantes 23 - La Costa 15 , Gigantes fue visitante',
                {
                  '1er inning': '2 carreras Gigantes, 0 carreras La Costa',
                  '2do inning': '1 carrera Gigantes, 3 carreras La Costa',
                  '3er inning': '3 carreras Gigantes, 0 carreras La Costa',
                  '4to inning': '2 carreras Gigantes, 5 carreras La Costa',
                  '5to inning': '5 carreras Gigantes, 4 carreras La Costa',
                  '6to inning': '5 carreras Gigantes, 0 carreras La Costa',
                  '7mo inning': '5 carreras Gigantes, 4 carreras La Costa',
                },
              ),
              _buildMatch(
                'Gigantes de Montevideo vs Vegueros',
                '24 de Noviembre 12.00pm, Estadio Charrua',
              ),
              _buildMatchWithBoxScore(
                'Gigantes de Montevideo vs Texas',
                '8 de Diciembre 3.00 pm, Estadio Charrua',
                'Resultado Gigantes 15 - Texas 7 , Gigantes fue visitante',
                {
                  '1er inning': '0 carreras Gigantes, 4 carreras Texas',
                  '2do inning': '8 carreras Gigantes, 3 carreras Texas',
                  '3er inning': '7 carreras Gigantes, 0 carreras Texas',
                  '4to inning': '0 carreras Gigantes, 0 carreras Texas',
                  '5to inning': '0 carreras Gigantes, 0 carreras Texas',
                },
              ),
              _buildMatchWithBoxScore(
                'Gigantes de Montevideo vs Cuba Libre',
                '15 de Diciembre 12.00 pm, Estadio Charrua (Semifinal)',
                'Resultado Cuba Libre 14 - Gigantes 6 , Gigantes fue local',
                {
                  '1er inning': '3 carreras Gigantes, 0 carreras Cuba Libre',
                  '2do inning': '0 carreras Gigantes, 4 carreras Cuba Libre',
                  '3er inning': '0 carreras Gigantes, 5 carreras Cuba Libre',
                  '4to inning': '0 carreras Gigantes, 3 carreras Cuba Libre',
                  '5to inning': '3 carreras Gigantes, 0 carreras Cuba Libre',
                  '6to inning': '0 carreras Gigantes, 2 carreras Cuba Libre',
                },
              ),
              _buildMatchWithBoxScore(
                'Gigantes de Montevideo vs Arizona',
                '22 de Diciembre 10.00 am, Estadio Charrua (Partido por el 3er lugar)',
                'Resultado Arizona 7 - Gigantes 15 , Gigantes fue local',
                {
                  '1er inning': '0 carreras Gigantes, 0 carreras Arizona',
                  '2do inning': '2 carreras Gigantes, 0 carreras Arizona',
                  '3er inning': '3 carreras Gigantes, 4 carreras Arizona',
                  '4to inning': '5 carreras Gigantes, 1 carrera Arizona',
                  '5to inning': '4 carreras Gigantes, 2 carreras Arizona',
                },
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
