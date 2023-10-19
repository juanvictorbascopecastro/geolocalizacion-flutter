class CiudadCreate {
  String nombre;
  String? descripcion;
  int id_departamento;

  CiudadCreate(
      {required this.nombre, this.descripcion, required this.id_departamento});

  static Map<String, dynamic> ciudadToMap(CiudadCreate ciudad) {
    final Map<String, dynamic> data = {
      "nombre": ciudad.nombre,
      "descripcion": ciudad.descripcion,
    };
    if (ciudad.id_departamento != null)
      data.addAll({"id_departamento": ciudad.id_departamento.toString()});
    return data;
  }
}
