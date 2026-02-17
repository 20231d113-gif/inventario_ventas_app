import 'package:flutter/material.dart';
import '../data/data_store.dart';

class AlertaStockScreen extends StatefulWidget {

  @override
  State<AlertaStockScreen> createState() => _AlertaStockScreenState();
}

class _AlertaStockScreenState extends State<AlertaStockScreen> {

  /// LIMITE STOCK BAJO
  final int limiteStock = 5;

  /// LISTA SOLO STOCK BAJO O SIN STOCK
  List get productosBajoStock {

    return productos.where((p){
      return p.stock <= limiteStock;
    }).toList();

  }

  /// DIALOGO REPONER STOCK
  void reponerStock(producto){

    TextEditingController nuevoStock = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(

          title: Text("Reponer Stock"),

          content: TextField(
            controller: nuevoStock,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Nuevo stock",
              border: OutlineInputBorder(),
            ),
          ),

          actions: [

            TextButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),

            ElevatedButton(
              child: Text("Guardar"),
              onPressed: (){

                int stockNuevo =
                    int.tryParse(nuevoStock.text) ?? producto.stock;

                setState(() {
                  producto.stock = stockNuevo;
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Stock actualizado 😎")),
                );
              },
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("⚠ Alertas de Stock"),
        backgroundColor: Colors.red,
      ),

      body: productosBajoStock.isEmpty

          /// SI NO HAY ALERTAS
          ? Center(
        child: Text(
          "Todo OK 😎",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green),
        ),
      )

      /// LISTA ALERTAS
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: productosBajoStock.length,
        itemBuilder: (_, i){

          final p = productosBajoStock[i];

          bool sinStock = p.stock == 0;

          return Card(

            elevation: 5,

            color: sinStock
                ? Colors.red.shade200
                : Colors.orange.shade100,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),

            child: ListTile(

              leading: Icon(
                sinStock
                    ? Icons.cancel
                    : Icons.warning,
                color: sinStock
                    ? Colors.red
                    : Colors.orange,
              ),

              title: Text(
                p.nombre,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              subtitle: Text(
                sinStock
                    ? "SIN STOCK ❌"
                    : "Stock bajo: ${p.stock}",
                style: TextStyle(
                    color: sinStock
                        ? Colors.red
                        : Colors.orange,
                    fontWeight: FontWeight.bold),
              ),

              trailing: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),

                icon: Icon(Icons.add),
                label: Text("Reponer"),

                onPressed: (){
                  reponerStock(p);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}