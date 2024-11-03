import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _professionAreaController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _errorMessage;
  bool _isHospitalStaff = false;

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _firestore.collection('usuarios').doc(userCredential.user?.uid).set({
        'nombre': _usernameController.text.trim(),
        'rut': _rutController.text.trim(),
        'esPersonalHospital': _isHospitalStaff,
        'areaDeProfesión': _isHospitalStaff ? _professionAreaController.text.trim() : null,
        'númeroDeTeléfono': _isHospitalStaff ? _phoneNumberController.text.trim() : null,
      });

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nombre de Usuario'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico', errorText: _errorMessage),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña', errorText: _errorMessage),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isHospitalStaff,
                  onChanged: (value) {
                    setState(() {
                      _isHospitalStaff = value!;
                    });
                  },
                ),
                const Text('¿Eres personal del hospital?'),
              ],
            ),
            TextField(
              controller: _rutController,
              decoration: const InputDecoration(labelText: 'RUT'),
            ),
            if (_isHospitalStaff) ...[
              TextField(
                controller: _professionAreaController,
                decoration: const InputDecoration(labelText: 'Área de la Profesión'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Número de Teléfono'),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text('Registrar')),
          ],
        ),
      ),
    );
  }
}
