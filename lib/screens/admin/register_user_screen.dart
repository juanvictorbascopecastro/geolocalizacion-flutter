import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/providers/providers.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:movil_location/widgets/widget.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {

  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: ( _ ) => PersonaFormCreateProvider(
          PersonaCreate(
              nombre: '',
              apellido: '',
              telefono: '',
              email: '',
              password: '',
              id_ciudad: 0)
      ),
      child: _PersonaScreenBody(),
    );
  }
}

class _PersonaScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personaService = Provider.of<PersonaService>(context);

    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Registrar Usuario', style: TextStyle(color: Colors.white),),
      ), */
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  UserImage(personaService: personaService),
                  Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp, size: 30, color: Colors.white,),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 30, color: Colors.white,),
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 100
                          );
                          if(pickedFile == null) {
                            print("No selecciono nada!");
                            return;
                          }
                          personaService.updateSelectImage(pickedFile.path);
                        },
                      )
                  )
                ],
              ),
              _UserForm(personaService: personaService),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserForm extends StatelessWidget {

  final PersonaService personaService;

  const _UserForm({
    Key? key,
    required this.personaService
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ciudadService = Provider.of<CiudadService>(context);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final personaForm = Provider.of<PersonaFormCreateProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration( labelText: 'Nombre', prefixIcon: Icons.person_outline_sharp),
              onChanged: ( value ) => personaForm.persona.nombre = value,
              validator: ( value ) {
                return value == null ? 'El nombre es requerido!' : value.length <= 0 ? 'El nombre es requerido!' : null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(labelText: 'Apellido', prefixIcon: Icons.person_outline_sharp),
              onChanged: ( value ) => personaForm.persona.apellido = value,
              validator: ( value ) {
                return value == null ? 'El apellido es requerido!' : value.length <= 0 ? 'El apellido es requerido!' : null;
              },
            ),
            const SizedBox(height: 15,),
            IntlPhoneField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialCountryCode: 'BO',
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(labelText: 'Celular'),
              invalidNumberMessage: '¡Número de celular no válido!',
              onChanged: ( value ) => personaForm.persona.telefono = value.countryCode + value.number,
              /*validator: (value) {
                    if(value == null) return null;
                    if(value.number.length <= 0) return null;
                    if(value!.isValidNumber()) return null;
                    else return '¡Número de celular no válido!';
                  },*/
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(labelText: 'Carnet de Identidad', prefixIcon: Icons.person_pin_sharp),
              onChanged: ( value ) => personaForm.persona.ci = value,
              validator: ( value ) {
                return value == null ? 'Carnet de identidad es requerido!' : value.length <= 0 ? 'Carnet de identidad es requerido!' : null;
              },
            ),
            const SizedBox(height: 10,),
            FutureBuilder(
                future: ciudadService.loadCiudad(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Ciudad>> snapshot) {
                  if (!snapshot.hasData) {
                    return DropdownButtonFormField<Ciudad>(
                        items: [],
                        decoration: InputDecorations.authInputDecoration(
                          hintText: 'Cargando...',
                          labelText: 'Ciudad',
                        ),
                        onChanged: (value) {}
                    ); //return CircularProgressIndicator(); // return Text('Cargando la ciudades...');
                  }
                  if (snapshot.data != null) {
                    if(snapshot.data!.isNotEmpty) personaForm.persona.id_ciudad = snapshot.data![0].id;
                    return DropdownButtonFormField<Ciudad>(
                        value: snapshot.data![0],
                        items: snapshot.data!.map((val) {
                          return DropdownMenuItem(
                              value: val,
                              child: Text(val.nombre)
                          );
                        }).toList(),
                        decoration: InputDecorations.authInputDecoration(
                          hintText: 'Seleccionar la ciudad...',
                          labelText: 'Ciudad',
                        ),
                        onChanged: (value) => personaForm.persona.id_ciudad = value!.id
                    );
                  }
                  return Container();
                }
            ),
            const SizedBox(height: 10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(labelText: 'Direccion', prefixIcon: Icons.location_city),
              onChanged: ( value ) => personaForm.persona.direccion = value,
            ),
            const SizedBox(height: 10,),
            DropdownButtonFormField<String>(
                value: 'empleado',
                items: const [
                  DropdownMenuItem(value: 'empleado', child: Text('Empleado'),),
                  DropdownMenuItem(value: 'usuario', child: Text('Usuario'),),
                  DropdownMenuItem(value: 'admin', child: Text('Administrador'),),
                ],
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Seleccionar Rol...',
                  labelText: 'Rol de usuario',
                ),
                onChanged: (value) => personaForm.persona.rol =  value ?? 'empleado'
            ),
            const SizedBox(height: 10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'ejemplo@ejemplo.com...',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.email
              ),
              onChanged: ( value ) => personaForm.persona.email = value,
              validator: ( value ) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : '¡El correo electrónico no es válido!';
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.key)
              ,
              onChanged: ( value ) => personaForm.persona.password = value,
              validator: ( value ) {
                return ( value != null && value.length >= 6 )
                    ? null
                    : '¡La contraseña debe tener más de 6 dígitos!';
              },
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: AppTheme.grey,
              elevation: 0,
              color: AppTheme.primary,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric( vertical: 15),
                  child: const Center(
                    child: Text("Guardar", style: TextStyle( color: Colors.white ),
                    ),
                  )
              ),
              onPressed: () async {
                // FocusScope.of(context).requestFocus(FocusNode());
                if(!myFormKey.currentState!.validate()) {
                  print('Formulario no valido');
                  return;
                }
                final response = await personaService.create(personaForm.persona);
                if(response == null) Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration () => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5,
        )
      ]
  );

}