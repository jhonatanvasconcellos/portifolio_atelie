import 'package:atelie_portifolio/core/models/selection_model.dart';
import 'package:atelie_portifolio/core/providers/selection_provider.dart';
import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/core/theme/app_spacing.dart';
import 'package:atelie_portifolio/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderSummaryBar extends ConsumerWidget {
  final SelectionModel selection;
  final bool canFinalize;
  final VoidCallback onFinalize;

  const OrderSummaryBar({
    super.key,
    required this.selection,
    required this.canFinalize,
    required this.onFinalize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: AppColors.white,
        // border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SummaryItem(
            title: 'Modelo:',
            itemName: selection.selectedModel?.name,
            onClear: () {
              ref.read(selectionProvider.notifier).clearModel();
            },
          ),

          AppSpacing.vertical8,

          _SummaryItem(
            title: 'Tecido:',
            itemName: selection.selectedFabric?.name,
            onClear: () {
              ref.read(selectionProvider.notifier).clearFabric();
            },
          ),

          AppSpacing.vertical12,

          if (canFinalize)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onFinalize,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dark,
                  foregroundColor: AppColors.white,
                ),
                icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18),
                label: Text(
                  'Solicite seu Orçamento',
                  style: AppTypography.button.copyWith(fontSize: 14),
                ),
              ),
            )
          else
            Text(
              'Selecione um modelo e um tecido para finalizar.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.white.withOpacity(0.6),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String? itemName;
  final VoidCallback onClear;

  const _SummaryItem({
    required this.title,
    this.itemName,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasItem = itemName != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.dark.withOpacity(0.8),
          ),
        ),
        AppSpacing.horizontal8,

        Expanded(
          child: Text(
            hasItem ? itemName! : '(Nenhum selecionado)',
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyMedium.copyWith(
              color: hasItem ? AppColors.dark : Colors.grey[600],
              fontWeight: hasItem ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),

        if (hasItem)
          IconButton(
            onPressed: onClear,
            icon: const FaIcon(
              FontAwesomeIcons.trash,
              color: Colors.red,
              size: 18,
            ),
          )
        else
          const SizedBox(width: 48),
      ],
    );
  }
}
