import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonReader {
  // Método para cargar y leer el archivo JSON
  Future<List<dynamic>> readJson(String filePath) async {
    try {
      // Cargar el archivo JSON como string
      final String response = await rootBundle.loadString(filePath);
      // Decodificar el string JSON a un Map
      final Map<String, dynamic> data = json.decode(response);
      return data['usuarios']; // Retorna la lista de usuarios
    } catch (e) {
      throw Exception('Error al leer el archivo JSON: $e');
    }
  }
}
