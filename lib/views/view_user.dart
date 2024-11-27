import 'package:flutter/material.dart';
import '../models/user.dart'; // Ruta corregida para el modelo User
import 'ChatView.dart'; // Ruta corregida para ChatView

class UserListView extends StatelessWidget {
  final List<User> users = [
    // Lista de usuarios con datos reales
    User(name: "Juan Pérez", rut: "12345678-9", chatId: "chat_juan"),
    User(name: "Ana Gómez", rut: "98765432-1", chatId: "chat_ana"),
    // Agrega más usuarios si es necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('${user.name} (${user.rut})'),
            subtitle: Text('Chat ID: ${user.chatId}'), // Información adicional (opcional)
            onTap: () {
              // Navegar a la vista de chat correspondiente al usuario seleccionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatView(chatId: user.chatId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
