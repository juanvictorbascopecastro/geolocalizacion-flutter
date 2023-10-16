import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';

class PersonaFormCreateProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PersonaCreate persona;

  PersonaFormCreateProvider(this.persona);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}