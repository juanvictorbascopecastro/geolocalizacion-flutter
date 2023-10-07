import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/screens/screens.dart';
import 'package:movil_location/services/services.dart';
import 'package:provider/provider.dart';

// verifica si tiene un usuario
class CheckAuthScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.getToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if(!snapshot.hasData) return Text('Espere');
              if(snapshot.data == '') {
                Future.microtask(() {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                      pageBuilder: ( _, __ , ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0)
                  ));
                });
              } else {
                // TODO: verificar los roles del usuario
                final Future<Persona?> personaFuture = authService.getPersona();
                personaFuture.then((value) => {
                  if(value!.usuario == null) {
                    Future.microtask(() {
                      Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: ( _, __ , ___) => const HomeScreen(),
                          transitionDuration: const Duration(seconds: 0)
                      ));
                    })
                  } else {
                    Future.microtask(() {
                      Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: ( _, __ , ___) => const AdminScreem(),
                          transitionDuration: const Duration(seconds: 0)
                      ));
                    })
                  }
                });

              }
              return Container();
          }
        ),
      ),
    );
  }

}