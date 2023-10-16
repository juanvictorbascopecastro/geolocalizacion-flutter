
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movil_location/services/auth_service.dart';
import 'package:provider/provider.dart';

class ErrorResponse {

  static void CheckError(Response response, BuildContext context) {
    print(response.body);
    if(response.statusCode == 401) {
      Provider.of<AuthService>(context).logout();
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}