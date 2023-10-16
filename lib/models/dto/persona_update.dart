import 'dart:convert';
import 'package:movil_location/models/models.dart';

class PersonaUpdate {
  int id;
  String nombre;
  String? apellido;
  String telefono;
  String? ci;
  String? direccion;
  int id_ciudad;
  String rol;
  String? fecha_nacimiento;
  String? foto;

  PersonaUpdate(
      {required this.nombre,
      required this.apellido,
      required this.telefono,
      this.ci,
      this.direccion,
      required this.id_ciudad,
      required this.rol,
      this.fecha_nacimiento,
      required this.id,
      this.foto});

  static Map<String, dynamic> personaToMap(PersonaUpdate persona) {
    final Map<String, dynamic> data = {
      "nombre": persona.nombre,
      "apellido": persona.apellido,
      "telefono": persona.telefono,
      "ci": persona.ci,
      "direccion": persona.direccion,
      "fecha_nacimiento": persona.fecha_nacimiento,
      "rol": persona.rol == 'empleado' ? null : persona.rol,
    };
    if (persona.id_ciudad != null)
      data.addAll({"id_ciudad": persona.id_ciudad.toString()});
    // if(persona.rol != null) data.addAll({ "rol" : persona.rol });
    return data;
  }
}
