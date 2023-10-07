import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class LoadingScreen extends StatelessWidget {

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /* appBar: AppBar(
        title: Text('Pagina de carga'),
      ),*/
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.primary,
        ),
      ),
    );
  }

}