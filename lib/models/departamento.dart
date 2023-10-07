import 'dart:convert';

class Departamento {
  int id;
  String nombre;
  String? descripcion;

  Departamento({
    required this.id,
    required this.nombre,
    this.descripcion
  });

  factory Departamento.fromJson(String str) => Departamento.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Departamento.fromMap(Map<String, dynamic> json) => Departamento(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      id: json['id'],
  );

}