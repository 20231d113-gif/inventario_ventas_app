class Venta {

  String id;
  double total;
  DateTime fecha;
  String tipoPago;

  /// 🔥 LISTA PRODUCTOS VENDIDOS
  List productos;

  Venta({
    required this.id,
    required this.total,
    required this.fecha,
    required this.tipoPago,
    required this.productos,
  });

}