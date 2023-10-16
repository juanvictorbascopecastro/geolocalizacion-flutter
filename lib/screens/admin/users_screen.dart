import 'package:flutter/material.dart';
import 'package:movil_location/models/Persona.dart';
import 'package:movil_location/models/dto/persona_update.dart';
import 'package:movil_location/screens/loading_screen.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/widgets/widget.dart';
import 'package:provider/provider.dart';
class UsersScreem extends StatelessWidget {

  const UsersScreem({super.key});

  @override
  Widget build(BuildContext context) {

    final personaService = Provider.of<PersonaService>(context);
    // if(personaService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: const AppBarAdmin(nameApp: 'Usuarios',),
      // backgroundColor: Colors.lightBlue,
      drawer:  SideMenuAdmin(),
      body: ListView.builder(
          itemCount: personaService.personas.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              Persona persona = personaService.personas[index].copy();
              personaService.selectedPersona = PersonaUpdate(
                nombre:           persona.nombre,
                apellido:         persona.apellido,
                telefono:         persona.telefono!,
                id_ciudad:        persona.ciudad!.id,
                id:               persona.id,
                rol:              persona.usuario != null ? persona.usuario!.rol : 'empleado',
                direccion:        persona.direccion,
                ci:               persona.ci,
                fecha_nacimiento: persona.fecha_nacimiento,
                foto:             persona.foto
              );
              Navigator.pushNamed(context, 'editUser');
            },
            child: CardUser(persona: personaService.personas[index], index: index,),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'register');
        },
        elevation: 10,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

}