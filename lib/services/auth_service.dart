import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/models/models.dart';
import 'package:movil_location/services/api_service.dart';

class AuthService extends ChangeNotifier {
  static const String path = '/auth';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    print('Consulta..');
    http.Response response = await http.post(
        Uri.parse("${ServiceApi.baseUrl}$path/sing-in"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(authData));
    Map<String, dynamic> mapData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Auth persona = Auth.fromMap(mapData);
      await storage.write(key: 'token', value: mapData['token']);
      await storage.write(key: 'user', value: jsonEncode(persona.toMap()));
      // final valueStorage = await storage.read(key: 'user');
      // print(valueStorage);
      return {'error': false, 'data': persona.usuario?.rol};
    }
    if (mapData.containsKey('error')) {
      // print(mapData['message']);
      // print(mapData['statusCode']);
      return {'error': true, 'message': mapData['message']};
    }
    return {'error': true, 'message': 'Ocurrio un error!'};
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user');
    return;
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<Auth?> getPersona() async {
    final value = await storage.read(key: 'user');
    if (value != null) {
      Map<String, dynamic> mapData = jsonDecode(value);
      Auth persona = Auth.fromMap(mapData);
      return persona;
    }
    return null;
  }
}
