import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/models/models.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'https://sis131.onrender.com/api/v1';
  static const String path = '/auth';
  final storage = new FlutterSecureStorage();

  Future<String?> login (String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    http.Response response = await http.post(Uri.parse("$_baseUrl$path/sing-in"),
        headers: { "Content-Type" : "application/json" },
        body: jsonEncode(authData)
    );
    Map<String, dynamic> mapData = jsonDecode(response.body);
    if(response.statusCode == 201) {
      Persona persona = Persona.fromMap(mapData);
      // Persona persona = Persona.fromMap(mapData);
      print(persona.nombre);
      await storage.write(key: 'token', value: mapData['token']);
      await storage.write(key: 'user', value: jsonEncode(persona.toMap()));
      // final valueStorage = await storage.read(key: 'user');
      // print(valueStorage);
      return null;
    }
    if(mapData.containsKey('error')) {
      print(mapData['message']);
      print(mapData['statusCode']);
      return mapData['message'];
    }
    return 'Ocurrio un error';
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user');
    return ;
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<Persona?> getPersona() async {
    final value = await storage.read(key: 'user');
    if(value != null) {
      Map<String, dynamic> mapData = jsonDecode(value);
      Persona persona = Persona.fromMap(mapData);
      return persona;
    }
    return null;
  }
}