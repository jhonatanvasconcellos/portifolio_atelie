import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class SelectionModel {
  final ItemModel? selectedModel;
  final ItemModel? selectedFabric;

  const SelectionModel({
    this.selectedModel,
    this.selectedFabric,
  });

  bool get hasSelection => selectedModel != null || selectedFabric != null;

  SelectionModel copyWith({
    ItemModel? selectedModel,
    ItemModel? selectedFabric,
  }) {
    return SelectionModel(
      selectedModel: selectedModel ?? this.selectedModel,
      selectedFabric: selectedFabric ?? this.selectedFabric,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectionModel &&
        other.selectedModel == selectedModel &&
        other.selectedFabric == selectedFabric;
  }

  @override
  int get hashCode => Object.hash(selectedModel, selectedFabric);
}