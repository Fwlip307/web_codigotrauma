import 'package:http/http.dart' as http;
import 'dart:convert';

class TelegramBotService {
  final String _token = '7937360366:AAEaEd5LlI9e35bKv06hLrvfgR-E0flCQpM';
  final String _baseUrl = 'https://api.telegram.org/bot';

  Future<void> handleUpdate(Map<String, dynamic> update) async {
    final message = update['message'];
    final chatId = message['chat']['id'];
    final text = message['text'];

    // Manejo del flujo de conversación
    if (text.toLowerCase() == "hola") {
      // Paso 1: Pedir nombre
      await sendMessage(chatId, "¡Hola! Por favor, indícame tu nombre completo.");
    } else if (!message.containsKey('userData')) {
      // Paso 2: Almacenar nombre y pedir RUT
      update['userData'] = {"name": text};
      await sendMessage(chatId, "Gracias. Ahora, por favor, envíame tu RUT.");
    } else if (message['userData']['name'] != null && !message['userData'].containsKey('rut')) {
      // Paso 3: Guardar el RUT y confirmar
      update['userData']['rut'] = text;
      await sendMessage(chatId, "Gracias. Tu nombre y RUT han sido registrados.");
    }
  }

  Future<void> sendMessage(int chatId, String text) async {
    final url = '$_baseUrl$_token/sendMessage';
    await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'chat_id': chatId,
        'text': text,
      }),
    );
  }
}
