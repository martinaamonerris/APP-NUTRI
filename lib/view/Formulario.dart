import 'package:flutter/material.dart';
import 'Plandieta.dart'; // Asegúrate de importar la página de Plan de Dieta

class FormularioView extends StatefulWidget {
  final String nombre; // Recibe el nombre del registro

  const FormularioView({Key? key, required this.nombre}) : super(key: key);

  @override
  FormularioViewState createState() => FormularioViewState();
}

class FormularioViewState extends State<FormularioView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _genero;
  String? _objetivo;
  String? _nivelActividad;
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.nombre, // Usa el nombre recibido del registro
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Completa el formulario con tus datos',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _edadController,
                    decoration: const InputDecoration(
                      labelText: 'Edad',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu edad';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Género',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Masculino'),
                        selected: _genero == 'Masculino',
                        onSelected: (selected) {
                          setState(() {
                            _genero = selected ? 'Masculino' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Femenino'),
                        selected: _genero == 'Femenino',
                        onSelected: (selected) {
                          setState(() {
                            _genero = selected ? 'Femenino' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Otro'),
                        selected: _genero == 'Otro',
                        onSelected: (selected) {
                          setState(() {
                            _genero = selected ? 'Otro' : null;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pesoController,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu peso';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _alturaController,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu altura';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nivel de Actividad',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Bajo'),
                        selected: _nivelActividad == 'Bajo',
                        onSelected: (selected) {
                          setState(() {
                            _nivelActividad = selected ? 'Bajo' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Moderado'),
                        selected: _nivelActividad == 'Moderado',
                        onSelected: (selected) {
                          setState(() {
                            _nivelActividad = selected ? 'Moderado' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Alto'),
                        selected: _nivelActividad == 'Alto',
                        onSelected: (selected) {
                          setState(() {
                            _nivelActividad = selected ? 'Alto' : null;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Objetivos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Perder peso'),
                        selected: _objetivo == 'Perder peso',
                        onSelected: (selected) {
                          setState(() {
                            _objetivo = selected ? 'Perder peso' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Ganar masa muscular'),
                        selected: _objetivo == 'Ganar masa muscular',
                        onSelected: (selected) {
                          setState(() {
                            _objetivo = selected ? 'Ganar masa muscular' : null;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Mantener peso'),
                        selected: _objetivo == 'Mantener peso',
                        onSelected: (selected) {
                          setState(() {
                            _objetivo = selected ? 'Mantener peso' : null;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Pasar los datos al Plan de Dieta
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DietPlanView(
                              nombre: widget.nombre,
                              edad: int.parse(_edadController.text),
                              peso: double.parse(_pesoController.text),
                              altura: double.parse(_alturaController.text),
                              nivelActividad: _nivelActividad!,
                              objetivo: _objetivo!,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
