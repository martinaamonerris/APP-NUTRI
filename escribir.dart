import 'dart:convert'; // Para codificar el JSON
import 'dart:io'; // Para escribir en archivos
import 'package:path_provider/path_provider.dart'; // Para obtener el directorio de almacenamiento local

class JsonWriter {
  // Método para escribir el archivo JSON con el nuevo usuario
  Future<void> escribirJson(List<Map<String, dynamic>> usuarios) async {
    try {
      // Convertir la lista de usuarios en formato JSON
      final jsonData = jsonEncode({'usuarios': usuarios});

      // Obtener el directorio de documentos de la aplicación
      final directory = await getApplicationDocumentsDirectory();

      // Crear la ruta del archivo JSON dentro de ese directorio
      final file = File('${directory.path}/usuarios.json');

      // Imprimir la ruta donde se guardará el archivo
      print("Archivo JSON guardado en: ${file.path}");

      // Escribir el archivo JSON
      await file.writeAsString(jsonData);
    } catch (e) {
      // En caso de error, mostrar mensaje
      throw Exception('Error al escribir el archivo JSON: $e');
    }
  }

  // Método para leer el archivo JSON
  Future<List<Map<String, dynamic>>> leerJson() async {
    try {
      // Obtener el directorio de documentos de la aplicación
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/usuarios.json');

      // Imprimir la ruta del archivo que se leerá
      print("Leyendo archivo desde: ${file.path}");

      // Verificar si el archivo existe
      if (await file.exists()) {
        // Leer el archivo como String
        final String response = await file.readAsString();

        // Decodificar el contenido de JSON a un Map
        final Map<String, dynamic> data = json.decode(response);

        // Retornar la lista de usuarios
        return List<Map<String, dynamic>>.from(
            data['usuarios'].map((user) => Map<String, dynamic>.from(user)));
      } else {
        // Si el archivo no existe, retornar una lista vacía
        return [];
      }
    } catch (e) {
      // En caso de error, mostrar mensaje
      throw Exception('Error al leer el archivo JSON: $e');
    }
  }
}
