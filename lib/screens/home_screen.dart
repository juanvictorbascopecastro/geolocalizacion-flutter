import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocalizacion', style: TextStyle(color: Colors.white),),
        elevation: 2,
        leading: IconButton(
            onPressed: () async {
              // final Persona? persona = await authService.getPersona();
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.login_outlined, color: Colors.white,)
        ),
      ),
      // backgroundColor: Colors.lightBlue,
      body: const Center(
        child: const Text('PAGINA DE INICIO DE USUARIO NORMAL')
      )
    );
  }

}