import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/models/dto/ciudad_create.dart';
import 'package:movil_location/providers/providers.dart';
import 'package:movil_location/services/ciudad_service.dart';
import 'package:movil_location/services/departamentos_services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:movil_location/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class SheetCiudadCreate extends StatelessWidget {
  final Ciudad? ciudad;

  const SheetCiudadCreate({super.key, this.ciudad});

  @override
  Widget build(BuildContext context) {
    final serviceCiudad = Provider.of<CiudadService>(context);

    return ChangeNotifierProvider<CiudadFormProvider>(
        create: (_) {
          Ciudad? cd = serviceCiudad.selectedCiudad;
          CiudadCreate ciudadCreate = serviceCiudad.selectedCiudad != null
              ? CiudadCreate(
                  nombre: cd!.nombre,
                  descripcion: cd!.descripcion,
                  id_departamento: cd!.departamento.id)
              : CiudadCreate(nombre: '', id_departamento: 0);
          return CiudadFormProvider(ciudadCreate);
        },
        child: _FormCiudad());
  }
}

class _FormCiudad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ciudadForm = Provider.of<CiudadFormProvider>(context);
    final departamentoService = Provider.of<DepartamentoService>(context);
    final ciudadService = Provider.of<CiudadService>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: ciudadForm.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: ciudadForm.ciudad.nombre,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Ciudad', prefixIcon: Icons.location_city_outlined),
            onChanged: (value) => ciudadForm.ciudad.nombre = value,
            validator: (value) {
              return value == null
                  ? 'El nombre de la ciudad es requerido!'
                  : value.isEmpty
                      ? 'El nombre de la ciudad es requerido!'
                      : null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: ciudadForm.ciudad.descripcion,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            maxLines: 2,
            decoration: InputDecorations.authInputDecoration(
              labelText: 'Descripcion',
            ),
            onChanged: (value) => ciudadForm.ciudad.descripcion = value,
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: departamentoService.loadDepartamento(),
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<Departamento>> snapshot) {
                if (!snapshot.hasData) {
                  return DropdownButtonFormField<Departamento>(
                      items: [],
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Cargando...',
                        labelText: 'Seleccionar el departamento ',
                      ),
                      onChanged: (value) {});
                }
                if (snapshot.data != null) {
                  if (snapshot.data!.isNotEmpty &&
                      ciudadForm.ciudad.id_departamento == 0) {
                    ciudadForm.ciudad.id_departamento = snapshot.data![0].id;
                  }
                  return DropdownButtonFormField<Departamento>(
                      value: snapshot.data!.firstWhere((element) =>
                          ciudadForm.ciudad.id_departamento == element.id),
                      items: snapshot.data!.map((val) {
                        return DropdownMenuItem(
                            value: val, child: Text(val.nombre));
                      }).toList(),
                      decoration: InputDecorations.authInputDecoration(
                        hintText: 'Seleccionar el departamento...',
                        labelText: 'Departamento',
                      ),
                      onChanged: (value) =>
                          ciudadForm.ciudad.id_departamento = value!.id);
                }
                return Container();
              }),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              if (!ciudadForm.isValidForm()) {
                print('Formulario no valido!');
              }
              FocusScope.of(context).unfocus();
              String? res;
              if (ciudadService.selectedCiudad != null)
                res = await ciudadService.updateData(
                    ciudadForm.ciudad, ciudadService.selectedCiudad!.id);
              else
                res = await ciudadService.create(ciudadForm.ciudad);
              if (res == null) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
