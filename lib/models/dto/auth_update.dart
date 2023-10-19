class AuthUpdate {
  String nombre;
  String? apellido;
  String telefono;
  String? ci;
  String? direccion;
  String email;
  String password;
  // String? rol;
  String? fecha_nacimiento;

  AuthUpdate({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    this.ci,
    this.direccion,
    required this.email,
    required this.password,
    this.fecha_nacimiento,
  });

  static Map<String, dynamic> personaToMap(AuthUpdate persona) {
    final Map<String, dynamic> data = {
      "nombre": persona.nombre,
      "apellido": persona.apellido,
      "telefono": persona.telefono,
      "ci": persona.ci,
      "direccion": persona.direccion,
      "fecha_nacimiento": persona.fecha_nacimiento,
      "email": persona.email,
      "password": persona.password,
    };
    return data;
  }
}
