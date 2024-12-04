# app.py
from flask import Flask, request
from telegram import Bot
import os
from dotenv import load_dotenv

load_dotenv()

# Obtener el token del archivo .env
bot_token = os.getenv("TELEGRAM_BOT_TOKEN")
chat_id = os.getenv("TELEGRAM_CHAT_ID")

bot = Bot(token=bot_token)

app = Flask(__name__)

@app.route("/telegram-webhook", methods=["POST"])
def telegram_webhook():
    # Obtiene el mensaje de Telegram
    data = request.get_json()
    message = data.get("message")
    
    if message:
        # Responder al mensaje
        bot.send_message(chat_id=message["chat"]["id"], text="Hola, ¿cómo puedo ayudarte?")
    
    return "OK", 200

if __name__ == "__main__":
    app.run(debug=True, port=5000)
