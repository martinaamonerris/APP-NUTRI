import 'package:flutter/material.dart';

class DietPlanView extends StatelessWidget {
  final String nombre;
  final int edad;
  final double peso;
  final double altura;
  final String nivelActividad;
  final String objetivo;

  const DietPlanView({
    Key? key,
    required this.nombre,
    required this.edad,
    required this.peso,
    required this.altura,
    required this.nivelActividad,
    required this.objetivo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double calorias = calcularCalorias();
    double proteinas = calcularProteinas();
    double carbohidratos = calcularCarbohidratos();
    double grasas = calcularGrasas();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan de Dieta',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Healthy Eating Enthusiast',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'PLAN DE DIETA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Chip(
                      label: Text(
                        objetivo,
                        style: const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Información Nutricional',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildNutrientCard(
                            'Calorías', '${calorias.toStringAsFixed(0)} kcal'),
                        _buildNutrientCard(
                            'Proteínas', '${proteinas.toStringAsFixed(0)} g'),
                        _buildNutrientCard('Carbohidratos',
                            '${carbohidratos.toStringAsFixed(0)} g'),
                        _buildNutrientCard(
                            'Grasas', '${grasas.toStringAsFixed(0)} g'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Acción al presionar el botón
                },
                child: const Text(
                  'Ver Recetas',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  double calcularCalorias() {
    double tmb = 10 * peso + 6.25 * altura - 5 * edad + 5;
    double multiplicador = 1.2;
    if (nivelActividad == 'Moderado') multiplicador = 1.5;
    if (nivelActividad == 'Alto') multiplicador = 1.7;
    return tmb * multiplicador;
  }

  double calcularProteinas() {
    if (objetivo == 'Ganar masa muscular') return peso * 2.2;
    if (objetivo == 'Perder peso') return peso * 1.5;
    return peso * 1.8;
  }

  double calcularCarbohidratos() {
    return calcularCalorias() * 0.55 / 4;
  }

  double calcularGrasas() {
    return calcularCalorias() * 0.25 / 9;
  }
}
