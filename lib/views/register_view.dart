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
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _errorMessage;
  bool _isHospitalStaff = false;
  String? _selectedProfession;
  String? _selectedShift;
  String? _additionalTraining;

  // Controladores para los horarios
  final TextEditingController _entryTimeController = TextEditingController();
  final TextEditingController _lunchTimeController = TextEditingController();
  final TextEditingController _exitTimeController = TextEditingController();

  final List<String> _professionOptions = [
    'Médicos de Urgencias o Emergencias',
    'Médicos Intensivistas',
    'Traumatólogos',
    'Cirujanos Generales',
    'Cardiólogos',
    'Neurólogos',
    'Pediatras de Emergencia',
    'Anestesiólogos',
    'Ginecólogos y Obstetras',
    'Enfermeros',
    'Auxiliar de ambulancia',
    'Conductor de ambulancia',
    'Enfermero de ambulancia'
  ];

  final List<String> _shiftOptions = [
    'Día',
    'Noche',
    'Rotativo',
  ];

  final List<String> _trainingOptions = [
    'Primeros Auxilios',
    'Gestión de Crisis',
    'RCP',
    'Atención Psicológica',
  ];

  Future<void> _register() async {
    // Validar campos
    if (_usernameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty || 
        _rutController.text.isEmpty || 
        (_isHospitalStaff && (_selectedProfession == null || _selectedShift == null))) {
      setState(() {
        _errorMessage = 'Por favor completa todos los campos.';
      });
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _firestore.collection('usuarios').doc(userCredential.user?.uid).set({
        'nombre': _usernameController.text.trim(),
        'rut': _rutController.text.trim(),
        'esPersonalHospital': _isHospitalStaff,
        'areaDeProfesión': _isHospitalStaff ? _selectedProfession : null,
        'númeroDeTeléfono': _isHospitalStaff ? _phoneNumberController.text.trim() : null,
        'jornada': _isHospitalStaff ? _selectedShift : null,
        'horarios': _isHospitalStaff ? {
          'entrada': _entryTimeController.text.trim(),
          'colacion': _lunchTimeController.text.trim(),
          'salida': _exitTimeController.text.trim(),
        } : null,
        'capacitaciones': _isHospitalStaff ? _additionalTraining : null,
      });

      // Navegar a la pantalla deseada, por ejemplo Home
      Navigator.pushReplacementNamed(context, '/home');
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Crear Cuenta',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de Usuario',
                        prefixIcon: const Icon(Icons.person, color: Colors.green),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        prefixIcon: const Icon(Icons.email, color: Colors.green),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorText: _errorMessage,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorText: _errorMessage,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _rutController,
                      decoration: InputDecoration(
                        labelText: 'RUT',
                        prefixIcon: const Icon(Icons.badge, color: Colors.green),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_isHospitalStaff) ...[
                      DropdownButtonFormField<String>(
                        value: _selectedProfession,
                        items: _professionOptions.map((profession) {
                          return DropdownMenuItem(
                            value: profession,
                            child: Text(profession),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _selectedProfession = value;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Área de Profesión',
                          prefixIcon: const Icon(Icons.work, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedShift,
                        items: _shiftOptions.map((shift) {
                          return DropdownMenuItem(
                            value: shift,
                            child: Text(shift),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _selectedShift = value;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Jornada Laboral',
                          prefixIcon: const Icon(Icons.access_time, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _additionalTraining,
                        items: _trainingOptions.map((training) {
                          return DropdownMenuItem(
                            value: training,
                            child: Text(training),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _additionalTraining = value;
                        }),
                        decoration: InputDecoration(
                          labelText: 'Capacitación Adicional',
                          prefixIcon: const Icon(Icons.school, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Número de Teléfono',
                          prefixIcon: const Icon(Icons.phone, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      // Campos de horarios
                      TextField(
                        controller: _entryTimeController,
                        decoration: InputDecoration(
                          labelText: 'Hora de Entrada (HH:mm)',
                          prefixIcon: const Icon(Icons.access_time, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _lunchTimeController,
                        decoration: InputDecoration(
                          labelText: 'Hora de Colación (HH:mm)',
                          prefixIcon: const Icon(Icons.access_time, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _exitTimeController,
                        decoration: InputDecoration(
                          labelText: 'Hora de Salida (HH:mm)',
                          prefixIcon: const Icon(Icons.access_time, color: Colors.green),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text('Registrarse'),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
