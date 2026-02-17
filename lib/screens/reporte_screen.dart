import 'package:flutter/material.dart';
import '../data/data_store.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class ReporteScreen extends StatefulWidget {
  @override
  State<ReporteScreen> createState() => _ReporteScreenState();
}

class _ReporteScreenState extends State<ReporteScreen> {

  DateTime? fechaInicio;
  DateTime? fechaFin;

  /// FILTRO FECHAS
  List get ventasFiltradas {

    if(fechaInicio == null || fechaFin == null){
      return ventas;
    }

    return ventas.where((v){

      return v.fecha.isAfter(
          fechaInicio!.subtract(Duration(days:1))) &&
          v.fecha.isBefore(
          fechaFin!.add(Duration(days:1)));

    }).toList();
  }

  /// TOTALES
  double get totalVentas =>
      ventasFiltradas.fold(0, (sum, v) => sum + v.total);

  double totalMetodo(String metodo){
    return ventasFiltradas
        .where((v)=>v.tipoPago == metodo)
        .fold(0, (sum, v)=> sum + v.total);
  }

  /// BOTONES RAPIDOS ULTRA PRO
  void filtroHoy(){
    final hoy = DateTime.now();
    setState(() {
      fechaInicio = hoy;
      fechaFin = hoy;
    });
  }

  void filtroSemana(){
    final hoy = DateTime.now();
    setState(() {
      fechaInicio = hoy.subtract(Duration(days:7));
      fechaFin = hoy;
    });
  }

  void filtroMes(){
    final hoy = DateTime.now();
    setState(() {
      fechaInicio = DateTime(hoy.year, hoy.month, 1);
      fechaFin = hoy;
    });
  }

  /// EXPORTAR PDF PRO
  Future generarPDF() async {

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context){

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text("Reporte de Ventas",
                  style: pw.TextStyle(fontSize: 20)),

              pw.SizedBox(height: 20),

              pw.Table.fromTextArray(

                headers: ["ID","Total","Metodo","Fecha"],

                data: ventasFiltradas.map((v)=>[
                  v.id,
                  "S/${v.total}",
                  v.tipoPago,
                  v.fecha.toString().split(" ")[0]
                ]).toList(),
              ),

              pw.SizedBox(height:20),

              pw.Text("Totales:"),

              pw.Text("Efectivo: S/${totalMetodo("efectivo")}"),
              pw.Text("Yape: S/${totalMetodo("yape")}"),
              pw.Text("Plin: S/${totalMetodo("plin")}"),
              pw.Text("Tarjeta: S/${totalMetodo("tarjeta")}"),

              pw.Divider(),

              pw.Text("TOTAL GENERAL: S/$totalVentas"),

            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Reportes de Ventas"),
        backgroundColor: Colors.deepPurple,
      ),

      body: ListView(
        padding: EdgeInsets.all(12),
        children: [

          /// BOTONES RAPIDOS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: filtroHoy, child: Text("HOY")),
              ElevatedButton(onPressed: filtroSemana, child: Text("SEMANA")),
              ElevatedButton(onPressed: filtroMes, child: Text("MES")),
            ],
          ),

          SizedBox(height:10),

          /// SELECTOR FECHAS
          Row(
            children: [

              Expanded(
                child: ElevatedButton(
                  child: Text(fechaInicio == null
                      ? "Fecha inicio"
                      : fechaInicio.toString().split(" ")[0]),

                  onPressed: () async {

                    final f = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100));

                    if(f!=null){
                      setState(()=> fechaInicio = f);
                    }
                  },
                ),
              ),

              SizedBox(width:10),

              Expanded(
                child: ElevatedButton(
                  child: Text(fechaFin == null
                      ? "Fecha fin"
                      : fechaFin.toString().split(" ")[0]),

                  onPressed: () async {

                    final f = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100));

                    if(f!=null){
                      setState(()=> fechaFin = f);
                    }
                  },
                ),
              ),

            ],
          ),

          SizedBox(height:20),

          /// ESTADISTICAS
          Card(
            child: ListTile(
              title: Text("Total vendido"),
              trailing: Text("S/$totalVentas",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          Card(child: ListTile(title: Text("Efectivo"), trailing: Text("S/${totalMetodo("efectivo")}"))),
          Card(child: ListTile(title: Text("Yape"), trailing: Text("S/${totalMetodo("yape")}"))),
          Card(child: ListTile(title: Text("Plin"), trailing: Text("S/${totalMetodo("plin")}"))),
          Card(child: ListTile(title: Text("Tarjeta"), trailing: Text("S/${totalMetodo("tarjeta")}"))),

          SizedBox(height:20),

          /// LISTA VENTAS
          ...ventasFiltradas.map((v)=>Card(
            child: ListTile(
              title: Text("S/${v.total}"),
              subtitle: Text("${v.tipoPago} - ${v.fecha}"),
            ),
          )),

          SizedBox(height:20),

          ElevatedButton.icon(
            icon: Icon(Icons.picture_as_pdf),
            label: Text("EXPORTAR PDF"),
            onPressed: generarPDF,
          )

        ],
      ),
    );
  }
}