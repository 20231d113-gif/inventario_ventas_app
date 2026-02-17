import '../models/producto.dart';
import '../models/venta.dart';

/// LISTA PRODUCTOS
List<Producto> productos = [

  Producto(
    id: 1,
    nombre: "Coca Cola",
    descripcion: "Bebida gaseosa 500ml",
    precio: 3.50,
    stock: 10,
    categoria: "Bebidas",
  ),

  Producto(
    id: 2,
    nombre: "Inka Cola",
    descripcion: "Bebida gaseosa 500ml",
    precio: 3.00,
    stock: 5,
    categoria: "Bebidas",
  ),

  Producto(
    id: 3,
    nombre: "Galletas Oreo",
    descripcion: "Galletas rellenas de chocolate",
    precio: 2.50,
    stock: 2,
    categoria: "Snacks",
  ),

  Producto(
    id: 4,
    nombre: "Chocolate Sublime",
    descripcion: "Chocolate con maní",
    precio: 1.50,
    stock: 0,
    categoria: "Dulces",
  ),

];

/// 🔥 CARRITO GLOBAL
List<Producto> carrito = [];

/// 🔥 LISTA VENTAS
List<Venta> ventas = [];
