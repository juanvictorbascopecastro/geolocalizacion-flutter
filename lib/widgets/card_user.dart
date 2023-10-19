import 'package:flutter/material.dart';
import 'package:movil_location/models/models.dart';
import 'package:movil_location/services/services.dart';
import 'package:movil_location/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CardUser extends StatelessWidget {
  final Persona persona;
  final int index;

  const CardUser({Key? key, required this.persona, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personaService = Provider.of<PersonaService>(context);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Row(
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: persona.foto == null
                  ? CircleAvatar(
                      backgroundColor:
                          index % 2 == 0 ? Colors.deepPurple : Colors.purple,
                      foregroundColor: Colors.white,
                      child: Text(
                        persona.nombre[0],
                        style: const TextStyle(fontSize: 28),
                      ),
                    )
                  : ClipOval(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          placeholderCacheWidth: 60,
                          placeholderCacheHeight: 60,
                          image: personaService.getUrlImage(
                              persona.foto!, 'persona'),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${persona.nombre} ${persona.apellido}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(persona.email,
                    style: const TextStyle(fontSize: 15, color: Colors.grey)),
              ],
            )
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              SwitchItem(
                  isSelected: persona.estado,
                  personaService: personaService,
                  id: persona.id)
            ],
          ),
        ),
        /* trailing: SizedBox(
            width: 70,
            child: Row(
              children: [
                InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {},
                ),
                InkWell(
                  child: const Icon(Icons.delete_outline),
                  onTap: () {},
                )
              ],
            ),
          ), */
      ),
    ));
  }
}

class SwitchItem extends StatelessWidget {
  bool isSelected;
  PersonaService personaService;
  int id;

  SwitchItem(
      {super.key,
      required this.isSelected,
      required this.personaService,
      required this.id});

  void itemSwitch(bool value) {
    // setState(() {
    isSelected = !isSelected;
    print(isSelected);
    personaService.updateState(isSelected, id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Switch(
      value: isSelected,
      activeColor: AppTheme.primary,
      onChanged: itemSwitch,
    );
  }
}
