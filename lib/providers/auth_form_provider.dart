import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';

class AuthFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  AuthUpdate auth;

  AuthFormProvider(this.auth);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
