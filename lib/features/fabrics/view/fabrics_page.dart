import 'package:atelie_portifolio/features/details/view/item_details_page.dart';
import 'package:atelie_portifolio/features/fabrics/provider/fabrics_provider.dart';
import 'package:atelie_portifolio/core/models/clothing_model.dart';

import 'package:atelie_portifolio/shared/widgets/item_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FabricsPage extends ConsumerWidget {
  const FabricsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemModel> fabrics = ref.watch(fabricsProvider);

    if (fabrics.isEmpty) {
      return const Center(
        child: Text('Nenhum tecido cadastrado no momento.'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: fabrics.length,
      itemBuilder: (context, index) {
        final item = fabrics[index];

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
