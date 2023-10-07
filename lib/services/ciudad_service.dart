import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movil_location/models/Persona.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;

class CiudadService extends ChangeNotifier {
  // final String _baseUrl = 'http://192.168.1.102:3000/api/v1';
  final String _baseUrl = 'https://sis131.onrender.com/api/v1';
  static const String path = '/ciudades';
  final List<Ciudad> ciudades = [];
  bool isLoading = true;

  CiudadService() {
    loadCiudad();
  }

  Future<List<Ciudad>> loadCiudad() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse(_baseUrl + path);
    final resp = await http.get(url);

    // print(jsonDecode(resp.body));

    List<dynamic> ciudadesMap = jsonDecode(resp.body);
    ciudadesMap.forEach((value) {
      final tempCiudad = Ciudad.fromMap(value);
      this.ciudades.add(tempCiudad);
    });

    this.isLoading = false;
    notifyListeners();

    return this.ciudades;
  }
}