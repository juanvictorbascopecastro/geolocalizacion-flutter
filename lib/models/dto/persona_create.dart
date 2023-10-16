class PersonaCreate {
  String nombre;
  String? apellido;
  String telefono;
  String? ci;
  String? direccion;
  String email;
  String password;
  int id_ciudad;
  String? rol;
  String? fecha_nacimiento;

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

  static Map<String, dynamic> personaToMap(PersonaCreate persona) {
    final Map<String, dynamic> data = {
      "nombre": persona.nombre,
      "apellido": persona.apellido,
      "telefono": persona.telefono,
      "ci": persona.ci,
      "direccion": persona.direccion,
      "fecha_nacimiento": persona.fecha_nacimiento,
      "email": persona.email,
      "password": persona.password,
      "rol": persona.rol == 'empleado' ? null : persona.rol,
    };
    if (persona.id_ciudad != null)
      data.addAll({"id_ciudad": persona.id_ciudad.toString()});
    return data;
  }
}
