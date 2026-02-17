import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      /// 🔥 TEMA GLOBAL (colores pro en toda la app)
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      /// PANTALLA INICIAL
      home: LoginScreen(),

    );
  }
}