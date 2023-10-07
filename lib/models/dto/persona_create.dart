
import 'dart:convert';

class PersonaCreate {
  final String nombre;
  final String? apellido;
  final String telefono;
  final String? ci;
  final String? direccion;
  final String email;
  final String password;
  final String id_ciudad;
  final String? rol;
  final String? fecha_nacimiento;

  PersonaCreate({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    this.ci,
    this.direccion,
    required this.email,
    required this.password,
    required this.id_ciudad,
    this.rol,
    this.fecha_nacimiento,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "nombre"            : nombre,
    "apellido"          : apellido,
    "telefono"          : telefono,
    "ci"                : ci,
    "direccion"         : direccion,
    "email"             : email,
    "password"          : password,
    "id_ciudad"         : id_ciudad,
    "rol"               : rol,
    "fecha_nacimiento"  : fecha_nacimiento
  };
}