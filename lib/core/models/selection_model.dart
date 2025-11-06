import 'package:atelie_portifolio/core/models/clothing_model.dart';

class SelectionModel {
  final ItemModel? selectedModel;
  final ItemModel? selectedFabric;

  SelectionModel({
    this.selectedModel,
    this.selectedFabric,
  });

  SelectionModel copyWith({
    ItemModel? selectedModel,
    ItemModel? selectedFabric,
  }) {
    return SelectionModel(
      selectedModel: selectedModel ?? this.selectedModel,
      selectedFabric: selectedFabric ?? this.selectedFabric,
    );
  }
}