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
                      'Repecho', 3, 3, 0, 38, 18, 20, 0.0, 1.000, 12.6, 6),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Carboneros', 3, 3, 0, 27, 8, 19, 0.0, 1.000, 9, 2.6),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Vegueros', 3, 2, 1, 22, 15, 7, 0.0, 0.667, 7.3, 5),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Cuba Libre', 3, 2, 1, 30, 15, 15, 1.0, 0.667, 10, 5),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Pa Goza', 3, 2, 1, 31, 22, 9, 1.0, 0.667, 10.3, 7.3),
                  SizedBox(height: 8),
                  _buildTeamRow('Mets', 3, 0, 3, 12, 39, -27, 3.0, 0.0, 4, 13),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Cerveceros', 3, 0, 3, 6, 22, -16, 3.0, 0.0, 2, 7.3),
                  SizedBox(height: 8),
                  _buildTeamRow(
                      'Gigantes', 3, 0, 3, 18, 45, -27, 3.0, 0.0, 6, 15),
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
