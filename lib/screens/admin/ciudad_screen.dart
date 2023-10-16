import 'package:flutter/material.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/widgets/widget.dart';
import 'package:provider/provider.dart';
class CiudadScreem extends StatelessWidget {

  const CiudadScreem({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: const AppBarAdmin(nameApp: 'Ciudades',),
        // backgroundColor: Colors.lightBlue,
        drawer:  SideMenuAdmin(),
        body: const Center(
            child: const Text('CIUDADES')
        )
    );
  }

}