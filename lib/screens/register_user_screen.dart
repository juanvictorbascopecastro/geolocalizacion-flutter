import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/screens/screens.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:movil_location/widgets/widget.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {

  final Persona? persona;

  const RegisterUserScreen({Key? key, this.persona }) : super(key : key);

  @override
  Widget build(BuildContext context) {

    final ciudadService = Provider.of<CiudadService>(context);
    final personaService = Provider.of<PersonaService>(context);

    if(ciudadService.isLoading) return LoadingScreen();

    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Registrar Usuario', style: TextStyle(color: Colors.white),),
      ),*/
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Stack(
                children: [
                  UserImage(url_umage: persona!.foto),
                  Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                        icon:  Icon(Icons.arrow_back_ios_sharp, size: 35, color: Colors.white,),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon:  Icon(Icons.camera_alt, size: 35, color: Colors.white,),
                        onPressed: () => Navigator.of(context).pop(),
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

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'nombre'    : '',
      'apellido'  : '',
      'email'     : '',
      'password'  : '',
      'telefono'  : '',
      'direccion' : '',
      'ci'        : '',
      'rol'       : 'admin'
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecorations.authInputDecoration( labelText: 'Nombre', prefixIcon: Icons.person_outline_sharp),
                  onChanged: ( value ) => formValues['nombre'] = value,
                  validator: ( value ) {
                    return value == null ? 'El nombre es requerido!' : value.length <= 0 ? 'El nombre es requerido!' : null;
                  },
                ),
                const SizedBox(width: 5,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(labelText: 'Apellido', prefixIcon: Icons.person_outline_sharp),
                  onChanged: ( value ) => formValues['apellido'] = value,
                  validator: ( value ) {
                    return value == null ? 'El apellido es requerido!' : value.length <= 0 ? 'El apellido es requerido!' : null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 15,),
            IntlPhoneField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialCountryCode: 'BO',
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(labelText: 'Celular'),
              invalidNumberMessage: '¡Número de celular no válido!',
              onChanged: ( value ) => formValues['telefono'] = value.countryCode + value.number,
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
              onChanged: ( value ) => formValues['ci'] = value,
              validator: ( value ) {
                return value == null ? 'Carnet de identidad es requerido!' : value.length <= 0 ? 'Carnet de identidad es requerido!' : null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(labelText: 'Direccion', prefixIcon: Icons.location_city),
              onChanged: ( value ) => formValues['direccion'] = value,
            ),
            const SizedBox(height: 15,),
            DropdownButtonFormField<String>(
                value: 'usuario',
                items: const [
                  DropdownMenuItem(value: 'usuario', child: Text('Usuario'),),
                  DropdownMenuItem(value: 'admin', child: Text('Administrador'),),
                ],
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Seleccionar Rol...',
                  labelText: 'Rol de usuario',
                ),
                onChanged: (value) => formValues['rol'] = value ?? 'usuario'
            ),
            const SizedBox(height: 15,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'ejemplo@ejemplo.com...',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.email
              ),
              onChanged: ( value ) => formValues['email'] = value,
              validator: ( value ) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : '¡El correo electrónico no es válido!';
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.key)
              ,
              onChanged: ( value ) => formValues['password'] = value,
              validator: ( value ) {
                return ( value != null && value.length >= 6 )
                    ? null
                    : '¡La contraseña debe tener más de 6 dígitos!';
              },
            ),
            const SizedBox(height: 15,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: AppTheme.grey,
              elevation: 0,
              color: AppTheme.primary,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric( vertical: 15),
                  child: Center(
                    child: Text("Guardar", style: const TextStyle( color: Colors.white ),
                    ),
                  )
              ),
              onPressed: () async {
                print(formValues);
                // FocusScope.of(context).requestFocus(FocusNode());
                if(!myFormKey.currentState!.validate()) {
                  print('Formulario no valido');
                  return;
                }
                // await personaService.create(formValues)
              },
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration () => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: Offset(0, 5),
          blurRadius: 5,
        )
      ]
  );

}