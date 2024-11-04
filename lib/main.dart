import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/home_view.dart' as home;
import 'views/login_view.dart' as login;
import 'views/register_view.dart';
import 'views/telegram_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const home.HomeView(), // Pantalla inicial
      routes: {
        '/login': (context) => const login.LoginView(),
        '/register': (context) => const RegisterView(),
        '/telegram': (context) => const TelegramView(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const home.HomeView());
      },
    );
  }
}
