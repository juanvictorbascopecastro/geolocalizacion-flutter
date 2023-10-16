import 'dart:convert';

class Departamento {
  int id;
  String nombre;
  String? descripcion;

  Departamento({required this.id, required this.nombre, this.descripcion});

  factory Departamento.fromJson(String str) =>
      Departamento.fromMap(jsonDecode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory Departamento.fromMap(Map<String, dynamic> json) => Departamento(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
      );
}
