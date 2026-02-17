import 'package:flutter/material.dart';
import 'venta_screen.dart';
import 'lista_productos_screen.dart';
import 'editar_producto_screen.dart';
import 'ventas_internas_screen.dart';
import 'login_screen.dart';
import 'alerta_stock_screen.dart';
import 'reporte_screen.dart';
import 'registrar_producto_screen.dart';

class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// APPBAR SUPERIOR
      appBar: AppBar(
        title: Text("Dashboard Inventario"),
        backgroundColor: Colors.deepPurple,
      ),

      /// MENU LATERAL (3 rayitas)
      drawer: Drawer(
        child: Container(

          /// COLOR LLAMATIVO
          color: Colors.deepPurple.shade50,

          child: ListView(
            children: [

              /// HEADER BONITO
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

              /// BOTON VENTA
              itemMenu(context, Icons.point_of_sale, "Venta", VentaScreen()),

              /// REGISTRAR PRODUCTO
              itemMenu(context, Icons.add_box, "Registrar productos", RegistrarProductoScreen()),

              /// EDITAR PRODUCTOS
              itemMenu(context,Icons.edit, "Lista productos", const ListaProductosScreen(),),

              /// VENTAS INTERNAS
              itemMenu(context, Icons.receipt_long, "Ventas internas", VentasInternasScreen()),

              /// REPORTE
              itemMenu(context, Icons.bar_chart, "Reporte ventas", ReporteScreen()),

              /// ALERTA STOCK
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
      ),

      /// PANTALLA PRINCIPAL
      body: Center(
        child: Text(
          "Bienvenida 😎",
          style: TextStyle(
            fontSize:24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  /// FUNCION PARA CREAR BOTONES MENU
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