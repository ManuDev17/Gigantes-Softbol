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
                '17 de Noviembre 2:00 pm, Estadio Charrua',
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
                '24 de Noviembre 12:00pm, Estadio Charrua',
                'Gigantes de Montevideo vs Vegueros',
              ),
              _buildMatch(
                '1 de Diciembre 3:00pm, Estadio Charrua',
                'Gigantes de Montevideo vs Texas',
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
