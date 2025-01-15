import 'package:flutter/material.dart';
import 'package:nutri/views/leer.dart'; // Importamos el archivo de lectura de JSON
import '/view/registro.dart'; // Asegúrate de que RegisterView esté importado
import '/view/formulario.dart'; // Asegúrate de que FormularioView esté importado

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Variable para cambiar entre login y registro
  bool isRegistering = false;

  String? validateEmail(String? value) {
    const emailRegex = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu email';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Por favor, ingresa un correo válido';
    }
    return null;
  }

  // Función para manejar el login
  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      final jsonReader = JsonReader();
      try {
        // Cargar los usuarios desde el archivo JSON
        List<dynamic> usuarios =
            await jsonReader.readJson('assets/usuarios.json');

        // Verificar si el usuario y la contraseña coinciden
        final user = usuarios.firstWhere(
          (usuario) =>
              usuario['email'] == emailController.text &&
              usuario['contraseña'] == passwordController.text,
          orElse: () => null,
        );

        if (user != null) {
          // Si el usuario existe, ir al formulario
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioView(
                nombre:
                    user['nombre'], // Pasar el nombre del usuario al formulario
              ),
            ),
          );
        } else {
          // Si no existe el usuario, mostrar mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al leer los datos: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Form(
            key: formKey, // Asocia el formKey al formulario
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nutri Score',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isRegistering ? 'Create an account' : 'Login to your account',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  isRegistering
                      ? 'Enter your details to create an account'
                      : 'Enter your email and password to login',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                    hintText: 'email',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail, // Aplica la validación
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Para que la contraseña no se vea
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  onPressed: handleLogin, // Manejo del login
                  child: Text(
                    isRegistering
                        ? 'Register'
                        : 'Login', // Cambiar entre registro y login
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Continue with Google'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.apple),
                  label: const Text('Continue with Apple'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'By clicking continue, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRegistering =
                          !isRegistering; // Cambiar entre registro y login
                    });
                    if (isRegistering) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(
                            email: emailController
                                .text, // Pasar el email a la página de registro
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    isRegistering
                        ? 'Already have an account? Login'
                        : 'Don\'t have an account? Register',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
