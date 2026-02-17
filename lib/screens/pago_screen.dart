import 'package:flutter/material.dart';
import '../data/data_store.dart';
import '../models/venta.dart';
import 'ventas_internas_screen.dart';

class PagoScreen extends StatefulWidget {

  final double total;

  PagoScreen(this.total);

  @override
  State<PagoScreen> createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {

  TextEditingController monto = TextEditingController();

  double vuelto = 0;

  calcularVuelto(String v){

    double recibido = double.tryParse(v) ?? 0;

    setState(() {
      vuelto = recibido - widget.total;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Pago"),
        backgroundColor: Colors.deepPurple,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            /// TOTAL GRANDE
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text("TOTAL A PAGAR",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height:8),
                  Text("S/${widget.total}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            SizedBox(height:25),

            /// INGRESAR MONTO
            TextField(
              controller: monto,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Dinero recibido",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: calcularVuelto,
            ),

            SizedBox(height:20),

            /// VUELTO
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text("Vuelto:",
                      style: TextStyle(fontSize:18)),
                  Text("S/$vuelto",
                      style: TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ],
              ),
            ),

            Spacer(),

            /// BOTON COBRAR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(18)),
              child: Text("COBRAR",
                  style: TextStyle(fontSize:18)),
              onPressed: (){

               ventas.add(
                 Venta(
                   id: DateTime.now().toString(),
                   total: widget.total,
                   fecha: DateTime.now(),
                   tipoPago: "efectivo",
                   productos: List.from(carrito), // 🔥 guarda detalle
                 )
                );

                carrito.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VentasInternasScreen()),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}