import 'package:flutter/material.dart';

class MessagingView extends StatefulWidget {
  const MessagingView({Key? key}) : super(key: key);

  @override
  _MessagingViewState createState() => _MessagingViewState();
}

class _MessagingViewState extends State<MessagingView> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Agrega el mensaje del usuario
        _messages.add('Tú: ${_controller.text}');
        
        // Simulación de respuesta del bot
        _messages.add('Bot: Respuesta automática'); // Aquí puedes implementar la lógica de respuesta del bot

        // Limpia el campo de entrada
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensajes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _messages[index],
                    style: TextStyle(
                      fontWeight: _messages[index].startsWith('Tú:') ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(), // Enviar mensaje al presionar Enter
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
