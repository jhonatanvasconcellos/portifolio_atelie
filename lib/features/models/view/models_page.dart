import 'package:atelie_portifolio/features/details/view/item_details_page.dart';
import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:atelie_portifolio/features/models/provider/models_provider.dart';
import 'package:atelie_portifolio/shared/widgets/item_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelsPage extends ConsumerWidget {
  const ModelsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemModel> models = ref.watch(modelsProvider);

    if (models.isEmpty) {
      return const Center(child: Text('Nenhum modelo cadastrado no momento.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0), 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            0.75,
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10, 
      ),

      itemCount: models.length, 

      itemBuilder: (context, index) {
        final item = models[index];

        return ItemGridCard(
          item: item,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailsPage(item: item),
              ),
            );
          },
        );
      },
    );
  }
}
