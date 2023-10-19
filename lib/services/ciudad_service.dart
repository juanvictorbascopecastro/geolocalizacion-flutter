import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';

class CiudadService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  static const String _path = '/ciudades';
  final List<Ciudad> ciudades = [];
  Ciudad? selectedCiudad;
  bool isLoading = true;

  CiudadService() {
    if (ciudades.isEmpty) loadCiudad();
  }

  Future<List<Ciudad>> loadCiudad() async {
    if (ciudades.isNotEmpty) return ciudades;
    isLoading = true;
    // notifyListeners();
    final url = Uri.parse('${ServiceApi.baseUrl}$_path');
    http.Response response = await http.get(url);
    List<dynamic> ciudadesMap = jsonDecode(response.body);
    ciudadesMap.forEach((value) {
      final tempCiudad = Ciudad.fromMap(value);
      ciudades.add(tempCiudad);
    });
    isLoading = false;
    notifyListeners();
    return ciudades;
  }

  bool isSaving = false;
  Future create(CiudadCreate ciudad) async {
    isSaving = true;
    notifyListeners();

    final String token = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('${ServiceApi.baseUrl}$_path');
    final http.Response response;
    String data = jsonEncode(CiudadCreate.ciudadToMap(ciudad));
    response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: data,
    );

    Map<String, dynamic> mapData = jsonDecode(response.body);
    print(mapData);
    if (response.statusCode == 201) {
      Ciudad newCiudad = Ciudad.fromMap(mapData);
      ciudades.add(newCiudad);
      isSaving = false;
      notifyListeners();
      return null;
    } else {
      return mapData['message'];
    }
  }

  Future updateData(CiudadCreate ciudad, int? id) async {
    isSaving = true;
    notifyListeners();

    final String token = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('${ServiceApi.baseUrl}$_path/${id}');
    final http.Response response;
    String data = jsonEncode(CiudadCreate.ciudadToMap(ciudad));
    response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: data,
    );

    /* */
    Map<String, dynamic> mapData = jsonDecode(response.body);
    print(mapData);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Ciudad newCiudad = Ciudad.fromMap(mapData);
      final index =
          ciudades.indexWhere((element) => element.id == newCiudad.id);
      ciudades[index] = newCiudad;
      isSaving = false;
      notifyListeners();
      return null;
    } else {
      return mapData['message'];
    }
  }
}
