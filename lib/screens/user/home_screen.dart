import 'package:flutter/material.dart';
import 'package:movil_location/widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  int myCurrentIndex = 0;
  List pages = const [];

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: const AppBarAdmin(nameApp: 'Inicio'),
      // backgroundColor: Colors.lightBlue,
      body: const Center(child: Text('PAGINA DE INICIO DE USUARIO NORMAL')),
      bottomNavigationBar: BottomNavigatorUsers(myCurrentIndex: myCurrentIndex),
    );
  }
}
