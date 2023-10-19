import 'dart:convert';

import 'package:movil_location/models/models.dart';

class Ciudad {
  int id;
  String nombre;
  String? descripcion;
  Departamento departamento;

  Ciudad({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.departamento,
  });

  factory Ciudad.fromJson(String str) => Ciudad.fromMap(jsonDecode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'departamento': departamento.toMap(),
    };
  }

  factory Ciudad.fromMap(Map<String, dynamic> json) => Ciudad(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        departamento: Departamento.fromMap(json['departamento']),
      );

  Ciudad copy() => Ciudad(
      id: this.id,
      nombre: this.nombre,
      descripcion: this.descripcion,
      departamento: this.departamento);
}
