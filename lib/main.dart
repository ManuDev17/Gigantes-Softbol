import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'firebase_options.dart'; // Archivo auto-generado de Firebase
import 'home_page.dart';
import 'calendar_page.dart';
import 'standings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'GigantesFont',
          ),
        ),
        buttonTheme: const ButtonThemeData(
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/standings': (context) => StandingsPage(),
      },
    );
  }
}
