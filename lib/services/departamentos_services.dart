import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';

class DepartamentoService extends ChangeNotifier {
  static const String _path = '/departamentos';
  final List<Departamento> departamentos = [];
  bool isLoading = true;

  DepartamentoService() {
    if (departamentos.isEmpty) loadDepartamento();
  }

  Future<List<Departamento>> loadDepartamento() async {
    if (departamentos.isNotEmpty) return departamentos;
    isLoading = true;
    // notifyListeners();
    final url = Uri.parse('${ServiceApi.baseUrl}$_path');
    http.Response response = await http.get(url);
    List<dynamic> deptoMap = jsonDecode(response.body);
    deptoMap.forEach((value) {
      final tempDepto = Departamento.fromMap(value);
      departamentos.add(tempDepto);
    });
    isLoading = false;
    notifyListeners();
    return departamentos;
  }
}
