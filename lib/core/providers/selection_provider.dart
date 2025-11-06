import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:atelie_portifolio/core/models/selection_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class SelectionNotifier extends StateNotifier<SelectionModel> {
  SelectionNotifier() : super(SelectionModel());

  void selectModel(ItemModel model) {
    state = state.copyWith(selectedModel: model);
  }

  void selectFabric(ItemModel fabric) {
    state = state.copyWith(selectedFabric: fabric);
  }
  
  void clearSelection() {
    state = SelectionModel();
  }
}

final selectionProvider = StateNotifierProvider<SelectionNotifier, SelectionModel>((ref) {
  return SelectionNotifier();
});