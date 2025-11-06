import 'package:atelie_portifolio/core/data/mock_data.dart';
import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modelsProvider = Provider<List<ItemModel>>((ref) {
  return MockData.clothingModels;
});
