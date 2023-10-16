import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';
import 'package:http_parser/http_parser.dart';

class PersonaService extends ChangeNotifier {
  static const String _path = '/usuarios';
  late PersonaUpdate? selectedPersona;
  final storage = const FlutterSecureStorage();

  final List<Persona> personas = [];
  bool isLoading = true;

  PersonaService() {
    selectedPersona = null;
    if (personas.isEmpty) loadData();
  }

  Future<List<Persona>> loadData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${ServiceApi.baseUrl}$_path');
    final String token = await storage.read(key: 'token') ?? '';
    final http.Response response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    print(jsonDecode(response.body));
    if (response.statusCode != 200) {
      // ErrorResponse.CheckError(response, context);
      return personas;
    }
    ;

    List<dynamic> personaMap = jsonDecode(response.body);
    personaMap.forEach((value) {
      final temp = Persona.fromMap(value);
      personas.add(temp);
    });

    isLoading = false;
    notifyListeners();

    return personas;
  }

  bool isSaving = false;
  Future create(PersonaCreate persona) async {
    isSaving = true;
    // notifyListeners();

    final String token = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('${ServiceApi.baseUrl}$_path');
    final http.Response response;
    if (newPictureFile == null) {
      String data = jsonEncode(PersonaCreate.personaToMap(persona));
      response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: data,
      );
    } else {
      final http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.fields['nombre'] = persona.nombre;
      request.fields['apellido'] = persona.apellido!;
      request.fields['telefono'] = persona.telefono;
      request.fields['ci'] = persona.ci!;
      if (persona.rol != null && persona.rol != 'empleado')
        request.fields['rol'] = persona.rol!;
      if (persona.fecha_nacimiento != null)
        request.fields['fecha_nacimiento'] = persona.fecha_nacimiento!;
      if (persona.direccion != null)
        request.fields['direccion'] = persona.direccion!;
      request.fields['id_ciudad'] = persona.id_ciudad.toString();
      request.fields['email'] = persona.email;
      request.fields['password'] = persona.password;
      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('foto', newPictureFile!.path,
              contentType: MediaType('image', 'png'));
      request.files.add(multipartFile);
      request.headers.addAll({'Authorization': 'Bearer $token'});
      // request.headers.addAll({ 'Content-Type': 'application/x-www-form-urlencoded' });
      final streamResponse = await request.send();
      response = await http.Response.fromStream(streamResponse);
    }
    /* */
    Map<String, dynamic> mapData = jsonDecode(response.body);
    print(mapData);
    if (response.statusCode == 201) {
      Persona newPersona = Persona.fromMap(mapData);
      personas.add(newPersona);
      isSaving = false;
      newPictureFile = null;
      notifyListeners();
      return null;
    } else {
      return mapData['message'];
    }
  }

  Future<String?> updatePersona(PersonaUpdate persona) async {
    isSaving = true;
    notifyListeners();
    final String token = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('${ServiceApi.baseUrl}$_path/${persona.id}');
    final http.Response response;
    if (newPictureFile == null) {
      String data = jsonEncode(PersonaUpdate.personaToMap(persona));
      response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: data,
      );
    } else {
      final http.MultipartRequest request = http.MultipartRequest('PATCH', url);
      request.fields['nombre'] = persona.nombre;
      request.fields['apellido'] = persona.apellido!;
      request.fields['telefono'] = persona.telefono;
      request.fields['ci'] = persona.ci!;
      if (persona.rol != null) {
        if (persona.rol == 'empleado') {
          request.fields['rol'] = '';
        } else {
          request.fields['rol'] = persona.rol;
        }
      }
      if (persona.fecha_nacimiento != null)
        request.fields['fecha_nacimiento'] = persona.fecha_nacimiento!;
      if (persona.direccion != null)
        request.fields['direccion'] = persona.direccion!;
      request.fields['id_ciudad'] = persona.id_ciudad.toString();
      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('foto', newPictureFile!.path,
              contentType: MediaType('image', 'png'));
      request.files.add(multipartFile);
      request.headers.addAll({'Authorization': 'Bearer $token'});
      final streamResponse = await request.send();
      response = await http.Response.fromStream(streamResponse);
    }
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      Persona persona = Persona.fromMap(mapData);
      final index = personas.indexWhere((element) => element.id == persona.id);
      personas[index] = persona;

      selectedPersona = PersonaUpdate(
          nombre: persona.nombre,
          apellido: persona.apellido,
          telefono: persona.telefono!,
          id_ciudad: persona.ciudad!.id,
          id: persona.id,
          foto: persona.foto,
          fecha_nacimiento: persona.fecha_nacimiento,
          ci: persona.ci,
          direccion: persona.direccion,
          rol: persona.usuario != null ? persona.usuario!.rol : 'empleado');

      isSaving = false;
      notifyListeners();
      return null;
    }
    return 'Ocurrio un error!';
  }

  File? newPictureFile;
  void updateSelectImage(String path) {
    if (selectedPersona != null) selectedPersona!.foto = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  String getUrlImage(String pathFoto, String routeFile) {
    List<String> listPath = pathFoto.split('/');
    String nameFile = listPath.last;
    return '${ServiceApi.baseUrl}$_path/$routeFile/$nameFile';
  }
}
