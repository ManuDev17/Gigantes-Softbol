import 'package:flutter/material.dart';

class StandingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Tabla de Posiciones',
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
          // Imagen de fondo que cubre toda la pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondonegroo.png', // Ruta de la imagen de fondo
              fit: BoxFit
                  .cover, // Cambiar a cover para que cubra todo el espacio
            ),
          ),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Encabezados de la tabla
                  _buildTableHeader(),
                  SizedBox(height: 10),
                  // Filas de equipos
                  _buildTeamRow(
                      'Carboneros', 7, 6, 1, 62, 23, 39, 0.0, .857, 8.8, 3.2),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Repecho', 7, 6, 1, 70, 33, 37, 0.0, 0.857, 10, 4.7),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Pa Goza', 7, 6, 1, 68, 32, 36, 0.0, 0.857, 9.7, 4.5),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Cerveceros', 7, 3, 4, 39, 40, -1, 3.0, 0.429, 5.5, 5.7),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Vegueros', 7, 3, 4, 50, 53, -3, 3.0, 0.429, 7.1, 7.5),
                  SizedBox(height: 8),
                  _buildTeamRow('Cuba Libre', 7, 2, 5, 54, 80, -26, 4.0, 0.286,
                      7.7, 11.4),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Mets', 7, 1, 6, 19, 60, -41, 5.0, 0.143, 2.7, 8.5),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Gigantes', 7, 1, 6, 55, 96, -41, 5.0, 0.143, 7.8, 13.7),
                  SizedBox(
                      height:
                          16), // Añadir espacio extra después del último equipo
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 2, // Índice actual de la tabla de posiciones
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
        onTap: (int index) {
          // Navegar a las diferentes páginas según el índice seleccionado
          if (index == 0) {
            Navigator.pushReplacementNamed(
                context, '/home'); // Ir a la pantalla de inicio
          } else if (index == 1) {
            Navigator.pushReplacementNamed(
                context, '/calendar'); // Ir al calendario
          } else if (index == 2) {
            // Ya estás en la página de posiciones, no necesitas hacer nada
          }
        },
      ),
    );
  }

  // Método para construir el encabezado de la tabla
  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text('Equipo',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('JJ',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('G',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('P',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('CF',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('CP',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('DIF',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('PRO',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('Ca x J',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Expanded(
            child: Text('Cp x J',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ],
    );
  }

  // Método para construir una fila para cada equipo
  Widget _buildTeamRow(String team, int jj, int g, int p, int cf, int cp,
      int dc, double dif, double pro, double ca_x_j, double cp_x_j) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(team, style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(jj.toString(), style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(g.toString(), style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(p.toString(), style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(cf.toString(), style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(cp.toString(), style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(dif.toStringAsFixed(1),
                style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(pro.toStringAsFixed(3),
                style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(ca_x_j.toStringAsFixed(1),
                style: TextStyle(color: Colors.white))),
        Expanded(
            child: Text(cp_x_j.toStringAsFixed(1),
                style: TextStyle(color: Colors.white))),
      ],
    );
  }
}
