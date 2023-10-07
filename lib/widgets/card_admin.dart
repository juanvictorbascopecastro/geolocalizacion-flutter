import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class CardAdmin extends StatelessWidget {
  const CardAdmin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [

            const ListTile(
              leading: Icon( Icons.photo_album_outlined, color: AppTheme.primary  ),
              title: Text('Soy un título'),
              subtitle: Text('Ad et cillum incididunt duis Lorem consectetur dolor ex irure consectetur do velit enim eiusmod. Mollit aliquip amet amet elit deserunt ex incididunt magna laboris.'),
            ),

            Padding(
              padding: const EdgeInsets.only( right: 5 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Ok'),
                  ),
                ],
              ),
            )

          ],
        )
    );
  }
}