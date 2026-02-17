import 'package:flutter/material.dart';
import '../data/data_store.dart';
import '../models/producto.dart';
import 'editar_producto_screen.dart';

class ListaProductosScreen extends StatelessWidget {
  const ListaProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📦 Editar Productos"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final Producto producto = productos[index];

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              title: Text(
                producto.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Precio: S/ ${producto.precio}  |  Stock: ${producto.stock}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.deepPurple),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditarProductoScreen(producto: producto),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
