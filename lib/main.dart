import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Importa Hive para Flutter
import 'package:softbol/models/player.dart';
import 'home_page.dart';
import 'calendar_page.dart';
import 'standings_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlayerAdapter()); // Registra el adaptador aquí
  runApp(SoftballStatsApp());
}

class SoftballStatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gigantes de Montevideo',
      theme: ThemeData(
        fontFamily: 'GigantesFont',
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'GigantesFont',
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      // Definir las rutas
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/standings': (context) => StandingsPage(),
      },
    );
  }
}
