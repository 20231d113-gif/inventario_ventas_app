import 'package:flutter/material.dart';
import '../data/data_store.dart';
import 'menu_drawer.dart';

class VentasInternasScreen extends StatefulWidget {

  @override
  State<VentasInternasScreen> createState() => _VentasInternasScreenState();
}

class _VentasInternasScreenState extends State<VentasInternasScreen> {

  DateTime? fechaSeleccionada;

  List get ventasFiltradas {

    if(fechaSeleccionada == null){
      return ventas;
    }

    return ventas.where((v){

      return v.fecha.year == fechaSeleccionada!.year &&
             v.fecha.month == fechaSeleccionada!.month &&
             v.fecha.day == fechaSeleccionada!.day;

    }).toList();
  }

  seleccionarFecha() async {

    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if(fecha != null){
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text("Ventas internas"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: seleccionarFecha,
          )
        ],
      ),

      body: ventasFiltradas.isEmpty
          ? Center(
              child: Text(
                "No hay ventas",
                style: TextStyle(fontSize:18),
              ),
            )
          : ListView.builder(
              itemCount: ventasFiltradas.length,
              itemBuilder: (_,i){

                final v = ventasFiltradas[i];

                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.shopping_cart,color:Colors.white),
                    ),
                    title: Text("Total: S/${v.total}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(v.fecha.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,color:Colors.red),
                      onPressed: (){
                        setState(() {
                          ventas.remove(v);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}