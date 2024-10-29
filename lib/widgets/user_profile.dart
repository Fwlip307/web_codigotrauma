import 'package:flutter/material.dart';

class UserProfileDialog extends StatelessWidget {
  final String username;

  UserProfileDialog({required this.username});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Perfil de Usuario'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nombre: $username'),
          // Agrega más detalles como el correo aquí
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
