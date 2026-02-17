import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../data/data_store.dart';

class EditarProductoScreen extends StatefulWidget {
  final Producto producto;

  const EditarProductoScreen({super.key, required this.producto});

  @override
  State<EditarProductoScreen> createState() =>
      _EditarProductoScreenState();
}

class _EditarProductoScreenState extends State<EditarProductoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nombreController;
  late TextEditingController precioController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();

    nombreController =
        TextEditingController(text: widget.producto.nombre);
    precioController =
        TextEditingController(text: widget.producto.precio.toString());
    stockController =
        TextEditingController(text: widget.producto.stock.toString());
  }

  void actualizarProducto() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.producto.nombre = nombreController.text;
        widget.producto.precio =
            double.parse(precioController.text);
        widget.producto.stock =
            int.parse(stockController.text);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Producto actualizado correctamente"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  InputDecoration estiloInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text("✏ Editar Producto"),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade200,
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Modificar Información",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 25),

                  TextFormField(
                    controller: nombreController,
                    decoration:
                        estiloInput("Nombre del producto", Icons.inventory),
                    validator: (value) =>
                        value!.isEmpty ? "Ingrese el nombre" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: precioController,
                    keyboardType: TextInputType.number,
                    decoration:
                        estiloInput("Precio", Icons.attach_money),
                    validator: (value) =>
                        value!.isEmpty ? "Ingrese el precio" : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration:
                        estiloInput("Stock", Icons.storage),
                    validator: (value) =>
                        value!.isEmpty ? "Ingrese el stock" : null,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: actualizarProducto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                      ),
                      child: const Text(
                        "💾 Guardar Cambios",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
