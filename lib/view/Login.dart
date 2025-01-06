import 'package:flutter/material.dart';
import 'Registro.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    String? validateEmail(String? value) {
      const emailRegex = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      } else if (!RegExp(emailRegex).hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null; // Null indica que no hay errores
    }

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
                const Text(
                  'Create an account',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your email to sign up for this app',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'email@domain.com',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail, // Aplica la validación
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(
                            email: emailController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
