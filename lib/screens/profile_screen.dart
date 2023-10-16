import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/services/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget{

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil de Usuario', style: TextStyle(color: Colors.white),),
          elevation: 2,
        ),
        // backgroundColor: Colors.lightBlue,
        body: Scaffold(
          body: Center(
            child: FutureBuilder(
                future: authService.getPersona(),
                builder: (BuildContext context, AsyncSnapshot<Auth?> snapshot) {
                  if(!snapshot.hasData) return Text('Espere');
                  print(snapshot.data!.nombre);
                  return Container();
                }
            ),
          ),
        )
    );
  }

}