import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeedService extends ChangeNotifier{
  final String _baseUrl = 'https://sis131.onrender.com/api/v1';
  static const String path = '/seed';

  Future  executeSeed () async {
    var response = await http.post(Uri.parse(_baseUrl + path),
        headers: { "Content-Type" : "application/json" },
    );
    print(jsonDecode(response.body));
  }
}