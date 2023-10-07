import 'package:flutter/material.dart';
import 'package:movil_location/themes/app_theme.dart';

class CardUser extends StatelessWidget {

  final String imageUrl;
  final String? name;

  const CardUser({
    Key? key,
    required this.imageUrl,
    this.name
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
        ),
        elevation: 30,
        shadowColor: AppTheme.primary.withOpacity(0.5),
        child: Column(
          children: [

            FadeInImage(
              image: NetworkImage( imageUrl ),
              placeholder: const AssetImage('assets/loading.gif'),
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
            ),


            if ( name != null )
              Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsets.only( right: 20, top: 10, bottom: 10 ),
                  child: Text( name ?? 'No Title' )
              )

          ],
        )
    );
  }
}