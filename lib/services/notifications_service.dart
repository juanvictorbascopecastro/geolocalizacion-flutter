import 'package:flutter/material.dart';

class NotificationService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, Color? backgroundColor, bool showCloseButton) {
    final snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white, fontSize: 18),),
        backgroundColor: backgroundColor,
        action: showCloseButton ? SnackBarAction(
          textColor: Colors.white,
          label: 'Cerrar',
          onPressed: () {
            // Cierra el SnackBar
            messengerKey.currentState!.hideCurrentSnackBar();
          },
        ) : null,
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}