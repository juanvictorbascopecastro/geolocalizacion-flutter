import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';

class DepartamentoService extends ChangeNotifier {
  static const String path = '/departamentos';
  final List<Departamento> departamentos = [];
  bool isLoading = true;

  DepartamentoService() {
    this.loadDepartamento();
  }

  Future loadDepartamento() async {
    final url = Uri.parse('${ServiceApi.baseUrl}$path');
    final resp = await http.get(url);
    // final Map<String, dynamic> personaMap = json.decode(resp.body);
    print(json.decode(resp.body));
  }
}