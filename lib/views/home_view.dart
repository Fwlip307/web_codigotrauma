import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isLargeScreen = constraints.maxWidth > 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Emergency App'),
            actions: [
              if (isLargeScreen) ...[
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    // Handle Home navigation here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Handle Settings navigation here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bienvenido a la App de Emergencias',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Métodos de Emergencia',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.phone_in_talk, color: Colors.green),
                  title: const Text('Llamar a los servicios de emergencia'),
                  subtitle: const Text('En caso de emergencia, llama al 911 o tu número local de emergencias.'),
                  onTap: () {
                    // Placeholder for functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.warning, color: Colors.green),
                  title: const Text('Conoce los procedimientos de primeros auxilios'),
                  subtitle: const Text('Aprende cómo actuar en caso de emergencia.'),
                  onTap: () {
                    // Placeholder for functionality
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.green),
                  title: const Text('Preparación ante emergencias'),
                  subtitle: const Text('Infórmate sobre cómo prepararte para posibles situaciones de emergencia.'),
                  onTap: () {
                    // Placeholder for functionality
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: isLargeScreen
              ? null
              : BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Inicio',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Ajustes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.login),
                      label: 'Iniciar Sesión',
                    ),
                  ],
                  currentIndex: 0, // Highlight the first tab as default
                  onTap: (int index) {
                    if (index == 2) {
                      Navigator.pushNamed(context, '/login');
                    }
                    // Add functionality for other tabs as needed
                  },
                ),
        );
      },
    );
  }
}
