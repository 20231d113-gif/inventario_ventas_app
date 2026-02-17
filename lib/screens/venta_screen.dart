import 'package:flutter/material.dart';
import '../data/data_store.dart';
import 'carrito_screen.dart';
import 'dashboard_screen.dart';

class VentaScreen extends StatefulWidget {
  @override
  State<VentaScreen> createState() => _VentaScreenState();
}

class _VentaScreenState extends State<VentaScreen> {

  /// 🔥 BUSCADOR
  TextEditingController buscador = TextEditingController();
  String textoBusqueda = "";

  @override
  Widget build(BuildContext context) {

    /// 🔥 FILTRO BUSQUEDA DINAMICA
    final productosFiltrados = productos.where((p){
      return p.nombre.toLowerCase()
          .contains(textoBusqueda.toLowerCase());
    }).toList();

    return Scaffold(

      /// MENU LATERAL
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Center(
                child: Text("MENÚ",
                    style: TextStyle(color: Colors.white,fontSize: 20)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()));
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text("Venta"),
        backgroundColor: Colors.deepPurple,
        actions: [

          /// 🔥 ICONO CARRITO CON CONTADOR
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),

                if(carrito.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        carrito.length.toString(),
                        style: TextStyle(fontSize: 10,color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CarritoScreen()));
            },
          )
        ],
      ),

      body: Column(
        children: [

          /// 🔥 BUSCADOR
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: buscador,
              decoration: InputDecoration(
                hintText: "Buscar producto...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (v){
                setState(() {
                  textoBusqueda = v;
                });
              },
            ),
          ),

          /// 🔥 LISTA PRODUCTOS
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: productosFiltrados.length,
              itemBuilder: (_, i){

                final p = productosFiltrados[i];

                bool sinStock = p.stock == 0;
                bool stockBajo = p.stock > 0 && p.stock <= 5;

                return Card(
                  elevation: 5,
                  color: sinStock
                      ? Colors.red.shade100
                      : stockBajo
                      ? Colors.orange.shade100
                      : Colors.white,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),

                  margin: EdgeInsets.symmetric(vertical: 6),

                  child: ListTile(

                    leading: Icon(
                      Icons.inventory,
                      color: sinStock
                          ? Colors.red
                          : Colors.deepPurple,
                    ),

                    title: Text(
                      p.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      sinStock
                          ? "SIN STOCK ❌"
                          : "Stock: ${p.stock}",
                      style: TextStyle(
                          color: sinStock
                              ? Colors.red
                              : stockBajo
                              ? Colors.orange
                              : Colors.black),
                    ),

                    trailing: Text(
                      "S/${p.precio}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),

                    /// 🔥 AGREGAR AL CARRITO
                    onTap: (){

                      /// ❌ BLOQUEAR SI NO HAY STOCK
                      if(p.stock <= 0){

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Producto sin stock ❌"),
                            backgroundColor: Colors.red,
                          ),
                        );

                        return;
                      }

                      /// ✅ AGREGAR Y DESCONTAR STOCK
                      setState(() {
                        carrito.add(p);
                        p.stock--;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Producto agregado 😎")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}