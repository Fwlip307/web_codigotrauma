import 'package:flutter/material.dart';
import 'ChatView.dart'; // Asegúrate de importar ChatView

class UserListView extends StatelessWidget {
  final List<Map<String, String>> users = [
    {'name': 'Juan Pérez', 'rut': '12345678-9', 'chatId': 'chat_juan'},
    {'name': 'Ana Gómez', 'rut': '98765432-1', 'chatId': 'chat_ana'},
    // Más usuarios
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
          final name = user['name'];
          final rut = user['rut'];
          final chatId = user['chatId'];

          return ListTile(
            title: Text('$name ($rut)'),
            onTap: () {
              // Navegar al ChatView y pasar chatId
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatView(chatId: chatId!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
