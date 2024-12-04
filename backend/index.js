const express = require('express');
const bodyParser = require('body-parser');
const TelegramBot = require('node-telegram-bot-api');
require('dotenv').config();

const app = express();
app.use(bodyParser.json());

const BOT_TOKEN = '7937360366:AAEaEd5LlI9e35bKv06hLrvfgR-E0flCQpM'; // Usa tu token aquí
const bot = new TelegramBot(BOT_TOKEN, { polling: true });

// Maneja los mensajes recibidos
bot.on('message', (msg) => {
    const chatId = msg.chat.id;
    const text = msg.text;

    if (text === '/start') {
        bot.sendMessage(chatId, 'Bienvenido! Por favor, ingresa tu nombre y RUT.');
    } else if (text) {
        // Aquí puedes agregar lógica para procesar el nombre y RUT
        bot.sendMessage(chatId, `Recibido: ${text}`);
    }
});

// Ruta para enviar mensajes a usuarios a través de la API
app.post('/send-message', (req, res) => {
    const { chatId, message } = req.body;

    bot.sendMessage(chatId, message)
        .then(() => res.status(200).send({ success: true }))
        .catch((err) => res.status(500).send({ success: false, error: err.message }));
});

// Inicia el servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});
