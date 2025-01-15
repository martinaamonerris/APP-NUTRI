import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final String category;

  const RecipePage({
    super.key,
    required this.category,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _showAllIngredients = false;
  bool _showAllInstructions = false;

  @override
  Widget build(BuildContext context) {
    final receta = _getRecetaPorCategoria(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receta de ${receta['titulo']}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  receta['imagen'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'No se pudo cargar la imagen',
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _showIngredientesDialog(receta);
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Ingredientes'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _showAllIngredients = !_showAllIngredients;
                    });
                  },
                  child: Row(
                    children: [
                      Text(_showAllIngredients ? 'Hide' : 'Read More '),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: _buildIngredientRows(receta),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _showInstruccionesDialog(receta);
                  },
                  icon: const Icon(Icons.library_books),
                  label: const Text('Instrucciones'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _showAllInstructions = !_showAllInstructions;
                    });
                  },
                  child: Row(
                    children: [
                      Text(_showAllInstructions ? 'Hide' : 'Read More '),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
            if (_showAllInstructions) ...[
              const SizedBox(height: 8),
              for (var i = 0; i < receta['instrucciones'].length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('${i + 1}. ${receta['instrucciones'][i]}'),
                ),
              const SizedBox(height: 16),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (receta['chips'] as List<String>)
                  .map((chipText) => Chip(label: Text(chipText)))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              receta['textoInfo'],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(receta['emoji'], style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                _showMacronutrientesDialog(receta);
              },
              icon: const Icon(Icons.analytics),
              label: const Text('Macronutrientes'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getRecetaPorCategoria(String cat) {
    switch (cat) {
      case 'Desayuno':
        return {
          'titulo': 'Desayuno Saludable',
          'imagen':
              'https://plus.unsplash.com/premium_photo-1714115034964-16b20994142a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                  '?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          'ingredientes': [
            {'nombre': 'Avena', 'detalle': '40 g', 'calorias': 150},
            {'nombre': 'Plátano', 'detalle': '1 unidad', 'calorias': 105},
            {'nombre': 'Leche', 'detalle': '200 ml', 'calorias': 100},
            {'nombre': 'Miel', 'detalle': '1 cda', 'calorias': 64},
          ],
          'instrucciones': [
            'Calienta la leche en un cazo.',
            'Agrega la avena y remueve.',
            'Cocina a fuego lento 5 minutos.',
            'Añade plátano troceado y miel.',
          ],
          'chips': ['Meal Planning', 'High Fiber'],
          'textoInfo': 'La avena es una excelente fuente de fibra.',
          'emoji': '🥣',
          'macronutrientes': 'Proteínas: 12g, Grasas: 6g, Carbohidratos: 42g',
        };

      case 'Comida':
        return {
          'titulo': 'Comida Rápida y Sana',
          'imagen':
              'https://plus.unsplash.com/premium_photo-1694141251686-16828ed92b3f?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                  '?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          'ingredientes': [
            {'nombre': 'Pechuga de pollo', 'detalle': '150 g', 'calorias': 200},
            {'nombre': 'Arroz integral', 'detalle': '100 g', 'calorias': 120},
            {'nombre': 'Brócoli', 'detalle': '100 g', 'calorias': 35},
            {'nombre': 'Aceite de oliva', 'detalle': '1 cda', 'calorias': 119},
          ],
          'instrucciones': [
            'Cocina el arroz integral.',
            'Saltea el brócoli con aceite.',
            'Cocina la pechuga de pollo a la plancha.',
            'Mezcla y aliña todo con especias al gusto.',
          ],
          'chips': ['Healthy Eating', 'Low Fat'],
          'textoInfo': 'Cocina el pollo a la plancha para reducir grasas.',
          'emoji': '🍛',
          'macronutrientes': 'Proteínas: 26g, Grasas: 8g, Carbohidratos: 38g',
        };

      case 'Cena':
        return {
          'titulo': 'Cena Ligera',
          'imagen':
              'https://plus.unsplash.com/premium_photo-1676106624139-34377777aecc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                  '?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          'ingredientes': [
            {'nombre': 'Ensalada mixta', 'detalle': '1 plato', 'calorias': 90},
            {'nombre': 'Salmón', 'detalle': '120 g', 'calorias': 208},
            {'nombre': 'Limón', 'detalle': 'al gusto', 'calorias': 5},
          ],
          'instrucciones': [
            'Lava y prepara la ensalada.',
            'Cocina el salmón a la plancha.',
            'Agrega jugo de limón al salmón.',
            'Sirve todo en un plato y disfruta.',
          ],
          'chips': ['Low Carb', 'Omega-3'],
          'textoInfo':
              'El salmón aporta proteínas y grasas saludables. Perfecto para una cena ligera.',
          'emoji': '🥗',
          'macronutrientes': 'Proteínas: 20g, Grasas: 10g, Carbohidratos: 5g',
        };

      case 'Snacks':
        return {
          'titulo': 'Snacks Saludables',
          'imagen':
              'https://images.unsplash.com/photo-1603199476744-c2453821db8a?q=80&w=1884&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                  '?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          'ingredientes': [
            {'nombre': 'Frutos secos', 'detalle': '30 g', 'calorias': 180},
            {'nombre': 'Yogur griego', 'detalle': '1 unidad', 'calorias': 130},
            {'nombre': 'Miel', 'detalle': '1 cda', 'calorias': 64},
          ],
          'instrucciones': [
            'Mezcla los frutos secos con el yogur.',
            'Añade un poco de miel para endulzar.',
            'Sirve en un cuenco y disfruta.',
          ],
          'chips': ['High Protein', 'Energy Boost'],
          'textoInfo':
              'Los frutos secos son una buena fuente de grasas saludables. El yogur griego aporta proteínas.',
          'emoji': '🥜',
          'macronutrientes': 'Proteínas: 8g, Grasas: 15g, Carbohidratos: 20g',
        };

      default:
        return {
          'titulo': 'Receta Desconocida',
          'imagen': 'https://via.placeholder.com/500x300?text=No+Recipe',
          'ingredientes': [],
          'instrucciones': [],
          'chips': [],
          'textoInfo': 'No hay info disponible para esta categoría.',
          'emoji': '❓',
          'macronutrientes': '',
        };
    }
  }

  void _showIngredientesDialog(Map<String, dynamic> receta) {
    final ingredientes = receta['ingredientes'] as List;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Ingredientes completos'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ingredientes.map<Widget>((ing) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '- ${ing['nombre']} (${ing['detalle']}) '
                    'Cal: ${ing['calorias']}',
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showInstruccionesDialog(Map<String, dynamic> receta) {
    final instrucciones = receta['instrucciones'] as List;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Instrucciones'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                instrucciones.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('${index + 1}. ${instrucciones[index]}'),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showMacronutrientesDialog(Map<String, dynamic> receta) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Macronutrientes'),
          content: Text(receta['macronutrientes'] ?? 'No disponible'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildIngredientRows(Map<String, dynamic> receta) {
    final ingredientes = receta['ingredientes'] as List;
    final ingredientesParaMostrar =
        _showAllIngredients ? ingredientes : ingredientes.take(2);

    return ingredientesParaMostrar.map<Widget>((ing) {
      return _buildIngredientRow(
        icon: Icons.food_bank_outlined,
        nombre: ing['nombre'],
        descripcion: ing['detalle'],
        calorias: ing['calorias'],
      );
    }).toList();
  }

  Widget _buildIngredientRow({
    required IconData icon,
    required String nombre,
    required String descripcion,
    required int calorias,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(descripcion),
              ],
            ),
          ),
          Text(
            'Cal: $calorias',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
