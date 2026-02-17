import 'package:flutter/material.dart';

import 'venta_screen.dart';
import 'registrar_producto_screen.dart';
import 'lista_productos_screen.dart';
import 'ventas_internas_screen.dart';
import 'login_screen.dart';
import 'alerta_stock_screen.dart';
import 'reporte_screen.dart';

class MenuDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: Container(

        color: Colors.deepPurple.shade50,

        child: ListView(

          children: [

            /// HEADER SUPERIOR
            DrawerHeader(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.pinkAccent,
                  ],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(Icons.store,color:Colors.white,size:45),

                  SizedBox(height:10),

                  Text(
                    "Mi Sistema Ventas",
                    style: TextStyle(
                      color:Colors.white,
                      fontSize:22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            itemMenu(context, Icons.point_of_sale, "Venta", VentaScreen()),

            itemMenu(context, Icons.add_box, "Registrar productos", RegistrarProductoScreen()),

            itemMenu(context,Icons.edit, "Lista productos", ListaProductosScreen(),),

            itemMenu(context, Icons.receipt_long, "Ventas internas", VentasInternasScreen()),

            itemMenu(context, Icons.bar_chart, "Reporte ventas", ReporteScreen()),

            itemMenu(context, Icons.warning, "Alerta stock", AlertaStockScreen(), color: Colors.red),

            Divider(),

            /// CERRAR SESION
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Cerrar sesión"),
              onTap: (){

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route)=>false,
                );

              },
            ),

          ],
        ),
      ),
    );
  }

  Widget itemMenu(BuildContext context, IconData icon, String text, Widget screen,{Color color = Colors.deepPurple}){

    return ListTile(
      leading: Icon(icon,color: color),
      title: Text(text),

      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );

      },
    );
  }

}