import 'dart:convert';

class Usuario {
  final int id;
  late final String rol;

  Usuario({required this.id, required this.rol});

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) =>
      Usuario(id: json['id'], rol: json['rol']);

  // Devuelve un Map<String, dynamic> con los valores de los atributos de la clase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rol': rol,
    };
  }
}
