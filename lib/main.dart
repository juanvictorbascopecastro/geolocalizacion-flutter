import 'package:flutter/material.dart';
import 'package:movil_location/router/app_router.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => AuthService() ),
          ChangeNotifierProvider(create: ( _ ) => DepartamentoService() ),
          ChangeNotifierProvider(create: ( _ ) => CiudadService() ),
          ChangeNotifierProvider(create: ( _ ) => PersonaService() ),

        ],
      child: MyApp(),
    );
  }

}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geolocalizacion',
      initialRoute: AppRoutes.initialRouter,
      scaffoldMessengerKey: NotificationService.messengerKey, // de forma global
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
      theme: AppTheme.lishtTheme
    );
  }
}