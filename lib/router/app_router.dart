import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/screens/screens.dart';

class AppRoutes {

  static const initialRouter = 'checking';

  static final menuOptions = <MenuOption> [
    MenuOption(route: 'home', name: 'Pantalla de inicio', screem: const HomeScreen(), icon: Icons.home),
    MenuOption(route: 'login', name: 'Iniciar session', screem: LoginScreen(), icon: Icons.login),
    MenuOption(route: 'admin', name: 'Pantalla de Administrador', screem: const AdminScreem(), icon: Icons.person),
    MenuOption(route: 'user', name: 'Pantalla de Usuario', screem: const UserScreem(), icon: Icons.people_alt),
    MenuOption(route: 'register', name: 'Registrar Usuario', screem: const RegisterUserScreen(), icon: Icons.person_add_outlined),
    MenuOption(route: 'checking', icon: Icons.refresh, name: 'Cargando datos', screem: CheckAuthScreen())
  ];

  /* static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'login': (BuildContext context) => const LoginScreen(),
  }; */

  static Map<String, Widget Function(BuildContext)> getAppRoutes () {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for(final opt in menuOptions) {
      appRoutes.addAll({ opt.route: (BuildContext context) => opt.screem });
    }
    return appRoutes;
  }

  static onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}