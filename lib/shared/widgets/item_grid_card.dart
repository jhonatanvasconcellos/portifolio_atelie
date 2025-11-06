import 'package:atelie_portifolio/core/models/clothing_model.dart';
import 'package:flutter/material.dart';

class ItemGridCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemGridCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2.0,
      child: InkWell( 
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                item.imagePaths[0], 
                fit: BoxFit.cover, 
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[400],
                      size: 48,
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis, 
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