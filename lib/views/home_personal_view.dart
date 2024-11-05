import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePersonalView extends StatelessWidget {
  final Map<String, dynamic> userDoc;

  const HomePersonalView({Key? key, required this.userDoc}) : super(key: key);

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/'); // Asegúrate de que la ruta inicial está configurada
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Datos Personales
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Datos Personales',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text('Nombre: ${userDoc['nombre'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                    Text('Correo: ${userDoc['email'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                    Text('RUT: ${userDoc['rut'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                    Text('Teléfono: ${userDoc['telefono'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                    Text('Área de Profesión: ${userDoc['area'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Horario de Trabajo
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Horario de Trabajo',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text('Jornada: ${userDoc['jornada'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                    Text('Horario: ${userDoc['horario'] ?? "No disponible"}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Capacitación Disponible
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capacitación Disponible',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text('Cursos de primeros auxilios, gestión de crisis, etc.', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
