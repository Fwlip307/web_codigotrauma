import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileDialog extends StatelessWidget {
  final String username;

  UserProfileDialog({required this.username});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'No disponible';

    return AlertDialog(
      title: Text('Perfil de Usuario'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nombre: $username'),
          Text('Correo: $userEmail'),
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
