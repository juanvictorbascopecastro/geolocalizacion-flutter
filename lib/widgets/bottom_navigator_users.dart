import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class BottomNavigatorUsers extends StatelessWidget {
  const BottomNavigatorUsers({
    super.key,
    required this.myCurrentIndex,
  });

  final int myCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(8, 20))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: myCurrentIndex,
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppTheme.primary,
          backgroundColor: Colors.white,
          onTap: (value) {
            print(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Inicio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Inicio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit_outlined), label: 'Inicio')
          ],
        ),
      ),
    );
  }
}
