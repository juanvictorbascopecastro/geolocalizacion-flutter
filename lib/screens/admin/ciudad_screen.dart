import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/screens/screens.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:movil_location/widgets/widget.dart';
import 'package:provider/provider.dart';

class CiudadScreem extends StatelessWidget {
  const CiudadScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceCiudad = Provider.of<CiudadService>(context);

    return Scaffold(
        appBar: const AppBarAdmin(
          nameApp: 'Ciudades',
        ),
        // backgroundColor: Colors.lightBlue,
        drawer: SideMenuAdmin(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              serviceCiudad.selectedCiudad = null;
              showBottomSheet(context);
            },
            child: const Icon(Icons.add)),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: serviceCiudad.ciudades.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Ciudad ciudad = serviceCiudad.ciudades[index].copy();
                  serviceCiudad.selectedCiudad = ciudad;
                  showBottomSheet(context);
                },
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        // leading: const Icon(Icons.location_city),
                        title: Text(serviceCiudad.ciudades[index].nombre),
                        subtitle: Text(
                            serviceCiudad.ciudades[index].departamento.nombre),
                      )
                    ],
                  ),
                ))));
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
            padding: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50),
            child: const SheetCiudadCreate()));
  }
}
