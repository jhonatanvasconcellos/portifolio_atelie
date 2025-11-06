// lib/core/data/mock_data.dart
import 'package:atelie_portifolio/core/models/clothing_model.dart';

// Esta classe vai guardar nossos dados simulados
class MockData {
  // Lista de Modelos de Roupa
  static final List<ItemModel> clothingModels = [
    ItemModel(
      id: 'm1',
      name: 'Vestido "Sonho de Verão"',
      description: 'Um vestido leve e fluído, perfeito para dias quentes.',
      imagePaths: [
        'assets/images/modelo1.jpeg',
        'assets/images/modelo1_2.jpeg',
      ], // Mude para o nome da sua imagem
    ),
    ItemModel(
      id: 'm2',
      name: 'Blusa "Elegância"',
      description: 'Blusa social com detalhes em renda na manga.',
      imagePaths: [
        'assets/images/modelo2.jpeg',
      ], // Mude para o nome da sua imagem
    ),
    ItemModel(
      id: 'm3',
      name: 'Saia "Primavera"',
      description: 'Saia midi plissada com estampa floral.',
      imagePaths: [
        'assets/images/modelo3.jpeg',
      ], 
    ),
    ItemModel(
      id: 'm4',
      name: 'Conjunto "Urbano"',
      description: 'Conjunto de moletom confortável e estiloso.',
      imagePaths: [
        'assets/images/modelo4.jpeg',
      ], 
    ),
  ];

  static final List<ItemModel> fabrics = [
    ItemModel(
      id: 't1',
      name: 'Linho Puro (Cru)',
      description: 'Tecido nobre, fresco e com toque rústico.',
      imagePaths: [
        'assets/images/tecido1.jpeg',
      ], 
    ),
    ItemModel(
      id: 't2',
      name: 'Viscose Estampada',
      description: 'Leve, com ótimo caimento e estampa exclusiva.',
      imagePaths: [
        'assets/images/tecido2.jpeg',
      ], 
    ),
    ItemModel(
      id: 't3',
      name: 'Crepe de Seda',
      description: 'Toque suave e luxuoso, ideal para peças de festa.',
      imagePaths: [
        'assets/images/tecido3.jpeg',
      ], 
    ),
    ItemModel(
      id: 't4',
      name: 'Algodão Pima',
      description: 'O algodão mais macio do mundo, antialérgico.',
      imagePaths: [
        'assets/images/tecido4.jpeg',
      ],
    ),
  ];
}
