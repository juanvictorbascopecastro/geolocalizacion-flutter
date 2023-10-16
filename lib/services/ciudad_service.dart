import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';

class CiudadService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  static const String path = '/ciudades';
  final List<Ciudad> ciudades = [];
  bool isLoading = true;

  CiudadService() {
    // if(ciudades.length <= 0) loadCiudad();
  }

  Future<List<Ciudad>> loadCiudad() async {
    if(ciudades.isNotEmpty) return ciudades;
    isLoading = true;
    // notifyListeners();

    final url = Uri.parse('${ServiceApi.baseUrl}$path');
    http.Response response = await http.get(url);



    List<dynamic> ciudadesMap = jsonDecode(response.body);
    // print(ciudadesMap);
    ciudadesMap.forEach((value) {
      final tempCiudad = Ciudad.fromMap(value);
      ciudades.add(tempCiudad);
    });

    isLoading = false;
    // notifyListeners();

    return ciudades;
  }
}