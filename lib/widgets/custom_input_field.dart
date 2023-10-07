import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class CustomInputFiend extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? prefixIcon;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final bool? obscureText;

  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputFiend({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.autofocus = false,
    this.keyboardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      autofocus: autofocus == null ? false : true,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      obscureText: obscureText == null ? false: true,
      onChanged: (value) => formValues[formProperty] = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          // counterText: '3 caracteres'
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.primary
              )
          ),
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),

      ),
    );
  }
  
}