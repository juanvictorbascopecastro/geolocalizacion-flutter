import 'dart:convert';
import 'package:movil_location/models/models.dart';

class Auth {
  int id;
  String nombre;
  String? apellido;
  String? direccion;
  String? ci;
  String? telefono;
  String email;
  String? fecha_nacimiento;
  String? foto;
  bool estado;
  Usuario? usuario;

  Auth({
    required this.id,
    required this.nombre,
    this.apellido,
    this.direccion,
    this.ci,
    this.telefono,
    required this.email,
    this.fecha_nacimiento,
    this.foto,
    required this.estado,
    this.usuario,
  });

  factory Auth.fromJson(String str) => Auth.fromMap(jsonDecode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'ci': ci,
      'direccion': direccion,
      'usuario': usuario?.toMap(),
      'telefono': telefono,
      'email': email,
      'fecha_nacimiento': fecha_nacimiento,
      'foto': foto,
      'estado': estado,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> json) => Auth(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        ci: json['ci'],
        direccion: json['direccion'],
        usuario:
            json['usuario'] != null ? Usuario.fromMap(json['usuario']) : null,
        telefono: json['telefono'],
        email: json['email'],
        fecha_nacimiento: json['fecha_nacimiento'],
        foto: json['foto'],
        estado: json['estado'],
      );

  Auth copy() => Auth(
        id: this.id,
        nombre: this.nombre,
        apellido: this.apellido,
        ci: this.ci,
        direccion: this.direccion,
        usuario: this.usuario,
        telefono: this.telefono,
        email: this.email,
        fecha_nacimiento: this.fecha_nacimiento,
        foto: this.foto,
        estado: this.estado,
      );
}
