import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';

class PersonaFormUpdateProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersonaUpdate persona;

  PersonaFormUpdateProvider(this.persona);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}