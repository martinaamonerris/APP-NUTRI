import 'package:flutter/material.dart';
import 'recetas_sugeridas.dart'; 

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
        title: const Text('Plan de Dieta'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100, 
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[300]!, blurRadius: 5, spreadRadius: 3),
                  ],
                ),
                child: Text(
                  'Objetivo: $objetivo',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Información Nutricional',
              textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      _buildNutrientCard('Calorías', '${calorias.toStringAsFixed(0)} kcal'),
                      const SizedBox(width: 20),
                      _buildNutrientCard('Proteínas', '${proteinas.toStringAsFixed(0)} g'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNutrientCard('Carbohidratos', '${carbohidratos.toStringAsFixed(0)} g'),
                      const SizedBox(width: 20),
                      _buildNutrientCard('Grasas', '${grasas.toStringAsFixed(0)} g'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecetasSugeridasView(),
                    ),
                  );
                },
                child: const Text(
                  'Ver Recetas',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard(String title, String value) {
    return Container(
      width: 150, 
      height: 100, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey[300]!, blurRadius: 5, spreadRadius: 3),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  double calcularCalorias() {
    double tmb = 10 * peso + 6.25 * altura - 5 * edad + 5; 
    double multiplicador = 1.2; 
    if (nivelActividad == 'Moderado') {
      multiplicador = 1.5;
    } else if (nivelActividad == 'Alto') {
      multiplicador = 1.7;
    }
    return tmb * multiplicador;
  }

  double calcularProteinas() {
    if (objetivo == 'Ganar masa muscular') {
      return peso * 2.2;
    } else if (objetivo == 'Perder peso') {
      return peso * 1.5;
    } else {
      return peso * 1.8;
    }
  }

  double calcularCarbohidratos() {
    return calcularCalorias() * 0.55 / 4; 
  }

  double calcularGrasas() {
    return calcularCalorias() * 0.25 / 9; 
  }
}
