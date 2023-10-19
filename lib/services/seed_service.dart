import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movil_location/services/api_service.dart';

class SeedService extends ChangeNotifier {
  static const String path = '/seed';

  SeedService() {
    executeSeed();
  }

  Future executeSeed() async {
    http.Response response = await http.post(
      Uri.parse('${ServiceApi.baseUrl}$path'),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
  }
}
