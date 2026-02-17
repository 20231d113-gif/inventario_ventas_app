import 'package:flutter/material.dart';
import '../data/data_store.dart';
import 'pago_screen.dart';

class CarritoScreen extends StatefulWidget {
  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {

  double total(){

    double t=0;
    for(var p in carrito){
      t += p.precio;
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Venta detalle"),
        backgroundColor: Colors.deepPurple,
      ),

      body: Column(
        children: [

          Expanded(
            child: carrito.isEmpty
                ? Center(child: Text("No hay productos"))
                : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: carrito.length,
              itemBuilder: (_,i){

                final p = carrito[i];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(vertical:8),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [

                        Icon(Icons.inventory,
                            color: Colors.deepPurple),

                        SizedBox(width:10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(p.nombre,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text("Precio: S/${p.precio}",
                                  style: TextStyle(color: Colors.green))
                            ],
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.close,
                              color: Colors.red),
                          onPressed: (){
                            setState(() {
                              carrito.removeAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("TOTAL:",
                        style: TextStyle(
                            fontSize:18,
                            fontWeight: FontWeight.bold)),
                    Text("S/${total()}",
                        style: TextStyle(
                            fontSize:18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold)),
                  ],
                ),

                SizedBox(height:10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.all(15)),
                    child: Text("COBRAR"),
                    onPressed: carrito.isEmpty ? null : (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PagoScreen(total())),
                      );

                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}