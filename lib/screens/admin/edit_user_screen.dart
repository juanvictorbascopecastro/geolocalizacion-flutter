import 'package:flutter/cupertino.dart';
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

class EditUserScreen extends StatelessWidget {

  const EditUserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final personaService = Provider.of<PersonaService>(context);

    return ChangeNotifierProvider(
        create: ( _ ) => PersonaFormUpdateProvider(personaService.selectedPersona!),
        child: _PersonaScreenBody(personaService: personaService),
    );
  }
}

class _PersonaScreenBody extends StatelessWidget {

  final PersonaService personaService;

  const _PersonaScreenBody({
    Key? key,
    required this.personaService
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  UserImage(personaService: personaService),
                  Positioned(
                      top: 30,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_sharp, size: 30, color: Colors.white,),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                  ),
                  Positioned(
                      top: 30,
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
              const SizedBox(height: 100,)
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
    final personaForm = Provider.of<PersonaFormUpdateProvider>(context);
    final PersonaUpdate personaUpdate = personaForm.persona;
    final ciudadService = Provider.of<CiudadService>(context);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

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
              initialValue: personaUpdate.nombre,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Nombre', prefixIcon: Icons.person_outline_sharp),
              onChanged: (value) => personaUpdate.nombre = value,
              validator: (value) {
                return value == null ? 'El nombre es requerido!' : value.isEmpty ? 'El nombre es requerido!' : null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              initialValue: personaUpdate.apellido,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icons.person_outline_sharp),
              onChanged: (value) => personaUpdate.apellido = value,
              validator: (value) {
                return value == null ? 'El apellido es requerido!' : value.isEmpty ? 'El apellido es requerido!' : null;
              },
            ),
            const SizedBox(height: 10,),
            IntlPhoneField(
              initialValue: personaUpdate.telefono,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialCountryCode: 'BO',
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Celular'),
              invalidNumberMessage: '¡Número de celular no válido!',
              onChanged: (value) => personaUpdate.telefono = value.countryCode + value.number,
              /*validator: (value) {
                    if(value == null) return null;
                    if(value.number.length <= 0) return null;
                    if(value!.isValidNumber()) return null;
                    else return '¡Número de celular no válido!';
                  },*/
            ),
            TextFormField(
              initialValue: personaUpdate.ci,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Carnet de Identidad',
                  prefixIcon: Icons.person_pin_sharp),
              onChanged: (value) => personaUpdate.ci = value,
              validator: (value) {
                return value == null
                    ? 'Carnet de identidad es requerido!'
                    : value.isEmpty
                    ? 'Carnet de identidad es requerido!'
                    : null;
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
                    return DropdownButtonFormField<Ciudad>(
                        value: snapshot.data!.firstWhere((element) => personaUpdate.id_ciudad == element.id),
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
                        onChanged: (value) => personaUpdate.id_ciudad = value!.id
                    );
                  }
                  return Container();
                }
            ),
            const SizedBox(height: 10,),
            TextFormField(
              initialValue: personaUpdate.direccion,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                  labelText: 'Direccion', prefixIcon: Icons.location_city),
              // inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')) ],
              onChanged: (value) => personaUpdate.direccion = value,
            ),
            const SizedBox(height: 10,),
            DropdownButtonFormField<String>(
                value: personaUpdate.rol,
                items: const [
                  DropdownMenuItem(value: 'empleado', child: Text('Empleado'),),
                  DropdownMenuItem(value: 'usuario', child: Text('Usuario'),),
                  DropdownMenuItem(value: 'admin', child: Text('Administrador'),),
                ],
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Seleccionar Rol...',
                  labelText: 'Rol de usuario',
                ),
                onChanged: (value) => personaUpdate.rol = value ?? 'empleado'
            ),
            const SizedBox(height: 10,),
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
                      "Guardar", style: const TextStyle(color: Colors.white),
                    ),
                  )
              ),
              onPressed: () async {
                // FocusScope.of(context).requestFocus(FocusNode());
                if (!myFormKey.currentState!.validate()) {
                  print('Formulario no valido');
                  return;
                }
                final response = await personaService.updatePersona(personaForm.persona);
                if(response == null) Navigator.pop(context);
                // await personaService.create(formValues)
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

    BoxDecoration _buildBoxDecoration() =>
      BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]
    );
}