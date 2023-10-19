import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';

class CiudadFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  CiudadCreate ciudad;

  CiudadFormProvider(this.ciudad);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
