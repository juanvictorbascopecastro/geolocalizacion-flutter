import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;

class PersonaService extends ChangeNotifier {
  final String _baseUrl = 'https://sis131.onrender.com/api/v1';
  static const String path = '/usuarios';
  late Persona selectedPersona;
  final storage = new FlutterSecureStorage();

  final List<Persona> personas = [];
  bool isLoading = true;

  CiudadService() {
    loadCiudad();
  }

  Future<List<Persona>> loadCiudad() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse(_baseUrl + path);
    final resp = await http.get(url, headers: {
          'Authorization': await storage.read(key: 'token') ?? ''
        });

    // print(jsonDecode(resp.body));

    List<dynamic> ciudadesMap = jsonDecode(resp.body);
    ciudadesMap.forEach((value) {
      final temp = Persona.fromMap(value);
      this.personas.add(temp);
    });

    this.isLoading = false;
    notifyListeners();

    return this.personas;
  }

  bool isSaving = false;
  Future create(PersonaCreate persona) async {
    isSaving = true;
    notifyListeners();

    final url = Uri.parse('${_baseUrl}${path}');
    final resp = await http.post(url, body: persona.toJson(), headers: {
      'Authorization': await storage.read(key: 'token') ?? ''
    });

    print(jsonDecode(resp.body));

    isSaving = false;
    notifyListeners();
  }
}