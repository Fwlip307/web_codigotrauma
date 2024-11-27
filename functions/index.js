const functions = require("firebase-functions");
const axios = require("axios");
const admin = require("firebase-admin");

admin.initializeApp();

const TELEGRAM_TOKEN = "7937360366:AAEaEd5LlI9e35bKv06hLrvfgR-E0flCQpM";
const TELEGRAM_API_URL = `https://api.telegram.org/bot${TELEGRAM_TOKEN}`;

exports.telegramWebhook = functions.https.onRequest(async (req, res) => {
  try {
    const message = req.body.message;
    if (!message || !message.chat || !message.text) {
      res.status(400).send("No se encontraron datos del mensaje.");
      return;
    }

    const chatId = message.chat.id.toString();
    const text = message.text.trim();

    const userRef = admin.firestore().collection("users").doc(chatId);
    const doc = await userRef.get();

    if (!doc.exists) {
      await axios.post(`${TELEGRAM_API_URL}/sendMessage`, {
        chat_id: chatId,
        text: "¡Hola! Por favor, ¿cuál es tu nombre?",
      });

      await userRef.set({
        step: "name",
        name: "",
        rut: "",
      });
    } else {
      const userData = doc.data();

      if (userData.step === "name") {
        await userRef.update({name: text, step: "rut"});

        await axios.post(`${TELEGRAM_API_URL}/sendMessage`, {
          chat_id: chatId,
          text: "Gracias por tu nombre. Ahora, por favor, envíame tu RUT.",
        });
      } else if (userData.step === "rut") {
        await userRef.update({rut: text, step: "completed"});

        await axios.post(`${TELEGRAM_API_URL}/sendMessage`, {
          chat_id: chatId,
          text: "Gracias por tu información. Ya estás registrado.",
        });
      }
    }

    res.status(200).send("OK");
  } catch (error) {
    console.error("Error procesando el webhook:", error.message);
    res.status(500).send("Error interno del servidor.");
  }
});
