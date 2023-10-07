import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/providers/login_form_provider.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:movil_location/widgets/auth_background.dart';
import 'package:movil_location/widgets/card_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox( height: 250 ),

                  CardContainer(
                      child: Column(
                        children: [

                          const SizedBox( height: 10 ),
                          Text('Acceso', style: Theme.of(context).textTheme.headline4 ),
                          const SizedBox( height: 30 ),
                          ChangeNotifierProvider(
                              create: ( _ ) => LoginFormProvider(),
                              child: _LoginForm()
                          )
                        ],
                      )
                  ),

                  // const SizedBox( height: 50 ),
                  // const Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
                  const SizedBox( height: 50 ),
                ],
              ),
            )
        )
    );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'ejemplo@ejemplo.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : '¡El correo electrónico no es válido!';
              },
            ),

            const SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {
                return ( value != null && value.length >= 6 )
                    ? null
                    : '¡La contraseña debe tener más de 6 dígitos!';
              },
            ),

            const SizedBox( height: 30 ),

            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: AppTheme.grey,
                elevation: 0,
                color: AppTheme.primary,
                onPressed: loginForm.isLoading ? null : () async {
                  FocusScope.of(context).unfocus();
                  // TODO: validar si el login es correcto
                  if( !loginForm.isValidForm() ) return;
                  loginForm.isLoading = true;
                  final String? errorResponse = await authService.login(loginForm.email, loginForm.password);
                  // await Future.delayed(const Duration(seconds: 2 ));
                  if(errorResponse == null) {
                    Navigator.of(context).pushReplacementNamed('home');
                  } else {
                    loginForm.isLoading = false;
                    NotificationService.showSnackbar(errorResponse, Colors.redAccent, true);
                  }

                },
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric( vertical: 15),
                  child: Center(
                    child: Text(
                      loginForm.isLoading
                          ? 'Verificando...'
                          : 'Ingresar',
                      style: const TextStyle( color: Colors.white ),
                    ),
                  )
               )
            )
          ],
        ),
      ),
    );
  }
}