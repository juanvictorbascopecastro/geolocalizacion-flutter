import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? url_umage;

  const UserImage({super.key, this.url_umage});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 320,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: url_umage == null
            ? const Image(
              image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
            )
            : FadeInImage(
              image: NetworkImage(url_umage!),
              placeholder: const AssetImage('assets/loading.gif'),
              fit: BoxFit.cover
          ),
        )
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    borderRadius: const BorderRadius.only( topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    color: Colors.red,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5)
      )
    ]
  );

}