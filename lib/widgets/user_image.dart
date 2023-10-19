import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movil_location/services/services.dart';

class UserImage extends StatelessWidget {
  final PersonaService personaService;

  const UserImage({super.key, required this.personaService});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 320,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: getImage()),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

  Widget getImage() {
    if (personaService.newPictureFile != null) {
      return Image.file(File(personaService.newPictureFile!.path),
          fit: BoxFit.cover);
    }
    if (personaService.selectedPersona == null ||
        personaService.selectedPersona!.foto == null) {
      return const Image(
        image: AssetImage('assets/no_image.png'),
        fit: BoxFit.cover,
      );
    }
    return FadeInImage(
        image: NetworkImage(personaService.getUrlImage(
            personaService.selectedPersona!.foto!, 'persona')),
        placeholder: const AssetImage('assets/loading.gif'),
        fit: BoxFit.cover);
  }
}
