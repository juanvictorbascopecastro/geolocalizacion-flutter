
import 'package:flutter/material.dart';
import 'package:movil_location/services/services.dart';
import 'package:provider/provider.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget{

  final String nameApp;

  const AppBarAdmin({super.key, required this.nameApp});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return AppBar(
      title: Text(nameApp, style: const TextStyle(color: Colors.white),),
      elevation: 2,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
            icon: const Icon(Icons.person_outline_sharp, color: Colors.white,)
        ),
        IconButton(
            onPressed: () async {
              // final Persona? persona = await authService.getPersona();
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: const Icon(Icons.login_outlined, color: Colors.white,)
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}