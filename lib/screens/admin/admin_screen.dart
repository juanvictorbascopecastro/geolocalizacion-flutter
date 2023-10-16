import 'package:flutter/material.dart';
import 'package:movil_location/widgets/widget.dart';
class AdminScreem extends StatelessWidget {

  const AdminScreem({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: const AppBarAdmin(nameApp: 'Inicio'),
        // backgroundColor: Colors.lightBlue,
        drawer:  SideMenuAdmin(),
        body: const Center(
            child: const Text('PAGINA DE INICIO ADMIN')
        )

    );
  }
}