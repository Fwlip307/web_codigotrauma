import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePersonalView extends StatelessWidget {
  final Map<String, dynamic> userDoc;

  const HomePersonalView({Key? key, required this.userDoc}) : super(key: key);

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Personal del Hospital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${userDoc['nombre']}'),
            Text('Correo: ${userDoc['email']}'),
            Text('RUT: ${userDoc['rut']}'),
            Text('Teléfono: ${userDoc['telefono']}'),
            Text('Área de Profesión: ${userDoc['area']}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
