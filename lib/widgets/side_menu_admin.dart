import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:provider/provider.dart';

class SideMenuAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),

            onTap: () {
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'homeAdmin');
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_history_outlined),
            title: const Text('Monitoreo'),
            onTap: () {
              // Navigator.pushReplacementNamed(context, 'ciudades');
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Historial de ubicacion'),
            onTap: () {
              // Navigator.pushReplacementNamed(context, 'ciudades');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt),
            title: const Text('Usuarios'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'users');
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: const Text('Ciudades'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'ciudades');
            },
          )
        ]
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return FutureBuilder(
      future: authService.getPersona(),
      builder: (BuildContext context, AsyncSnapshot<Auth?> snapshot) {
        if(!snapshot.hasData) return Text('Cargando...');
        /*return UserAccountsDrawerHeader(
          accountName: Text('${snapshot.data!.nombre} ${snapshot.data!.apellido}'),
          accountEmail: Text(snapshot.data!.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(snapshot.data!.nombre.substring(0, 1),style: const TextStyle(fontSize: 40.4),),
          ),
        );*/
        return DrawerHeader(
          decoration: const BoxDecoration(
            /* image: DecorationImage(
                image: AssetImage('assets/'),
                fit: BoxFit.cover
              ), */
              color:AppTheme.primary
          ),
          child: Align(
          alignment: Alignment.topLeft,
           child: Column(
             children: [
               CircleAvatar(
                 backgroundColor: Colors.blue,
                 radius: 32,
                 child: Center(
                   // padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
                   child: Text(snapshot.data!.nombre.substring(0, 1),style: const TextStyle(fontSize: 40),),
                 ),
               ),
               const SizedBox(height: 10,),
               Text(
                   '${snapshot.data!.nombre} ${snapshot.data!.apellido}',
                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)
               ),
               const SizedBox(height: 5,),
               Text(
                   snapshot.data!.email,
                   style: const TextStyle(color: Colors.white, fontSize: 14)
               ),
             ],
           )
          ),
        );
      }
    );
  }
}