import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    String? hintText,
    required String labelText,
    IconData? prefixIcon
  }) {

    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppTheme.primary_2
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppTheme.primary_2,
                width: 2
            )
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: AppTheme.grey),
        prefixIcon: prefixIcon != null
            ? Icon( prefixIcon, color: AppTheme.primary_2 )
            : null
    );
  }

}