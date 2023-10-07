import 'dart:convert';

import 'package:movil_location/models/models.dart';

class Ciudad {
  int id;
  String nombre;
  String descripcion;
  Departamento departamento;

  Ciudad({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.departamento,
  });

  Ciudad.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nombre = map['nombre'],
        descripcion = map['descripcion'],
        departamento = Departamento.fromMap(map['departamento']);

  // factory Ciudad.fromJson(String str) => Ciudad.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  /*factory Ciudad.fromMap(String json) => Ciudad(
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    id: json['id'],
    departamento: Departamento.fromJson(json['departamento']),
  );*/

}