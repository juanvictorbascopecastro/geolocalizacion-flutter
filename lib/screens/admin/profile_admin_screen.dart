import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/providers/auth_form_provider.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:movil_location/widgets/user_image.dart';
import 'package:provider/provider.dart';

class ProfileAdminScreen extends StatelessWidget {
  const ProfileAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        // backgroundColor: Colors.lightBlue,
        body: FutureBuilder(
            future: authService.getPersona(),
            builder: (BuildContext context, AsyncSnapshot<Auth?> snapshot) {
              if (!snapshot.hasData) return Text('Cargando perfil...');
              if (snapshot.data != null) {
                return ChangeNotifierProvider(
                  create: (_) {
                    final authUpdate = AuthUpdate(
                        nombre: snapshot.data!.nombre,
                        apellido: snapshot.data!.apellido,
                        email: snapshot.data!.email,
                        password: '',
                        telefono: snapshot.data!.telefono!,
                        ci: snapshot.data!.ci!,
                        direccion: snapshot.data!.direccion,
                        fecha_nacimiento: snapshot.data!.fecha_nacimiento);
                    return AuthFormProvider(authUpdate);
                  },
                  child: _ProfileScreenBody(),
                );
              }
              return Container();
            }));
  }
}

class _ProfileScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final personaService = Provider.of<PersonaService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  UserImage(personaService: personaService),
                  Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_sharp,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 100);
                          if (pickedFile == null) {
                            print("No selecciono nada!");
                            return;
                          }
                          personaService.updateSelectImage(pickedFile.path);
                        },
                      ))
                ],
              ),
              _AuthForm(authService: authService),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  final AuthService authService;

  const _AuthForm({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ciudadService = Provider.of<CiudadService>(context);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final authForm = Provider.of<AuthFormProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Nombre', prefixIcon: Icons.person_outline_sharp),
              onChanged: (value) => authForm.auth.nombre = value,
              validator: (value) {
                return value == null
                    ? 'El nombre es requerido!'
                    : value.isEmpty
                        ? 'El nombre es requerido!'
                        : null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icons.person_outline_sharp),
              onChanged: (value) => authForm.auth.apellido = value,
              validator: (value) {
                return value == null
                    ? 'El apellido es requerido!'
                    : value.length <= 0
                        ? 'El apellido es requerido!'
                        : null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            IntlPhoneField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialCountryCode: 'BO',
              keyboardType: TextInputType.phone,
              decoration:
                  InputDecorations.authInputDecoration(labelText: 'Celular'),
              invalidNumberMessage: '¡Número de celular no válido!',
              onChanged: (value) =>
                  authForm.auth.telefono = value.countryCode + value.number,
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
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Carnet de Identidad',
                  prefixIcon: Icons.person_pin_sharp),
              onChanged: (value) => authForm.auth.ci = value,
              validator: (value) {
                return value == null
                    ? 'Carnet de identidad es requerido!'
                    : value.length <= 0
                        ? 'Carnet de identidad es requerido!'
                        : null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Direccion', prefixIcon: Icons.location_city),
              onChanged: (value) => authForm.auth.direccion = value,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'ejemplo@ejemplo.com...',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.email),
              onChanged: (value) => authForm.auth.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : '¡El correo electrónico no es válido!';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.key),
              onChanged: (value) => authForm.auth.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : '¡La contraseña debe tener más de 6 dígitos!';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: AppTheme.grey,
              elevation: 0,
              color: AppTheme.primary,
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Center(
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              onPressed: () async {
                // FocusScope.of(context).requestFocus(FocusNode());
                if (!myFormKey.currentState!.validate()) {
                  print('Formulario no valido');
                  return;
                }
                // final response = await authService.updateProfile(authForm.auth);
                // if (response == null) Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}
