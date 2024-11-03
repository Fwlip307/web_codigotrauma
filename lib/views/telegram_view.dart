import 'package:flutter/material.dart';

class TelegramView extends StatelessWidget {
  const TelegramView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telegram')),
      body: const Center(
        child: Text('Interfaz de Mensajería aquí'),
      ),
    );
  }
}
