import 'package:flutter/material.dart';
import 'venta_screen.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(Icons.store, size: 60, color: Colors.deepPurple),

                SizedBox(height: 10),

                Text(
                  "Bienvenido a InvStore",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: "Usuario",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text("Iniciar Sesión"),
                    onPressed: () {

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => VentaScreen()),
                      );

                    },
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: Text("¿No tienes cuenta? Registrarse"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}