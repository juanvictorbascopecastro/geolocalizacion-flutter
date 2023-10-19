import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/screens/screens.dart';

class AppRoutes {
  static const initialRouter = 'checkAuth';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'checkAuth',
        icon: Icons.settings,
        name: 'Cargando Interfaz',
        screem: CheckAuthScreen()),
    MenuOption(
        route: 'home',
        name: 'Pantalla de inicio',
        screem: HomeScreen(),
        icon: Icons.home),
    MenuOption(
        route: 'login',
        name: 'Iniciar session',
        screem: const LoginScreen(),
        icon: Icons.login),
    MenuOption(
        route: 'checking',
        icon: Icons.refresh,
        name: 'Cargando datos',
        screem: CheckAuthScreen()),
    MenuOption(
        route: 'homeAdmin',
        name: 'Pantalla de Administrador',
        screem: const AdminScreem(),
        icon: Icons.person),
    MenuOption(
        route: 'users',
        name: 'Usuarios',
        screem: const UsersScreem(),
        icon: Icons.person),
    MenuOption(
        route: 'register',
        name: 'Registrar Usuario',
        screem: const RegisterUserScreen(),
        icon: Icons.person_add_outlined),
    MenuOption(
        route: 'ciudades',
        name: 'Ciudades',
        screem: const CiudadScreem(),
        icon: Icons.person_add_outlined),
    MenuOption(
        route: 'editUser',
        name: 'Editar Usuario',
        screem: const EditUserScreen(),
        icon: Icons.person_pin_outlined),
    MenuOption(
        route: 'profileEmpleado',
        name: 'Perfil de Usuario',
        screem: const ProfileEmpleadoScreen(),
        icon: Icons.person_pin),
    MenuOption(
        route: 'profileAdmin',
        name: 'Perfil de Usuario',
        screem: const ProfileAdminScreen(),
        icon: Icons.person_pin),
  ];

  /* static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'login': (BuildContext context) => const LoginScreen(),
  }; */

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final opt in menuOptions) {
      appRoutes.addAll({opt.route: (BuildContext context) => opt.screem});
    }
    return appRoutes;
  }

  static onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
