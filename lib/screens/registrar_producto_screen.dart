import 'package:flutter/material.dart';
import '../data/data_store.dart';
import '../models/producto.dart';
import 'menu_drawer.dart';

class RegistrarProductoScreen extends StatefulWidget {
  const RegistrarProductoScreen({super.key});

  @override
  State<RegistrarProductoScreen> createState() =>
      _RegistrarProductoScreenState();
}

class _RegistrarProductoScreenState
    extends State<RegistrarProductoScreen> {

  TextEditingController nombre = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController stock = TextEditingController();

  String categoria = "General";

 guardarProducto() {
  if (nombre.text.isEmpty ||
      precio.text.isEmpty ||
      stock.text.isEmpty) return;

  productos.add(
    Producto(
      id: productos.length + 1,
      nombre: nombre.text,
      descripcion: descripcion.text,
      precio: double.parse(precio.text),
      stock: int.parse(stock.text),
      categoria: categoria,
    ),
  );

  Navigator.pop(context);
}



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text("Registro de Producto"),
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(

          padding: EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey.shade300,
              )
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Detalles del Producto",
                style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              SizedBox(height:20),

              campo("Nombre del producto", nombre),
              campo("Descripción", descripcion),
              campo("Precio", precio, number:true),
              campo("Stock", stock, number:true),

              SizedBox(height:10),

              DropdownButtonFormField(
                value: categoria,
                items: [
                  "General",
                  "Bebidas",
                  "Snacks",
                  "Lácteos"
                ]
                .map((e)=>DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
                onChanged: (v){
                  categoria = v.toString();
                },
                decoration: InputDecoration(
                  labelText: "Categoría",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height:30),

              /// BOTON PRO
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: Text(
                    "GUARDAR PRODUCTO",
                    style: TextStyle(fontSize:16),
                  ),

                  onPressed: guardarProducto,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// CAMPO INPUT BONITO
  Widget campo(String label, TextEditingController controller,{bool number=false}) {

    return Padding(
      padding: EdgeInsets.only(bottom:15),
      child: TextField(
        controller: controller,
        keyboardType:
            number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}