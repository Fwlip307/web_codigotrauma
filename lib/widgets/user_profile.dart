import 'package:flutter/material.dart';

class UserProfileDialog extends StatelessWidget {
  final String username;

  const UserProfileDialog({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Perfil de Usuario'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nombre: $username'),
          // Agrega más detalles como el correo aquí
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
