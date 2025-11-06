import 'package:atelie_portifolio/core/providers/selection_provider.dart';
import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:atelie_portifolio/features/details/provider/item_details_provider.dart';

class ItemDetailsPage extends ConsumerWidget {
  final ItemModel item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.black, 
        foregroundColor: Colors.white, 
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: PageView.builder(
                controller: pageController,
                itemCount: item.imagePaths.length,
                onPageChanged: (index) {
                  ref.read(itemDetailsPageIndexProvider.notifier).state = index;
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    item.imagePaths[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (item.imagePaths.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: item.imagePaths.length,
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor:
                          theme.colorScheme.primary, 
                      dotColor: Colors.grey[300]!,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                      height: 1.5, 
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity, 
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        bool isModel = item.id.startsWith('m');

                        if (isModel) {
                          ref
                              .read(selectionProvider.notifier)
                              .selectModel(item);
                        } else {
                          ref
                              .read(selectionProvider.notifier)
                              .selectFabric(item);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} selecionado!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                       item.id.startsWith('m')
                          ? 'Selecionar este modelo'
                          : 'Selecionar este tecido',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
