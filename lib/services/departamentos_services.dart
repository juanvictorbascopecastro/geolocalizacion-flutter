import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:http/http.dart' as http;

class DepartamentoService extends ChangeNotifier {
  final String _baseUrl = 'http://192.168.1.102:3000/api/v1';
  static const String path = '/departamentos';
  final List<Departamento> departamentos = [];
  bool isLoading = true;

  DepartamentoService() {
    this.loadDepartamento();
  }

  Future loadDepartamento() async {
    final url = Uri.parse(_baseUrl + path);
    final resp = await http.get(url);
    // final Map<String, dynamic> personaMap = json.decode(resp.body);
    print(json.decode(resp.body));
  }
}