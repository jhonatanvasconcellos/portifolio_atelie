import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/core/theme/app_spacing.dart';
import 'package:atelie_portifolio/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.socialLink});

  final String? socialLink;

  Future<void> _launchUrl() async {
    if (socialLink != null && socialLink!.isNotEmpty) {
      final Uri url = Uri.parse(socialLink!);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (kDebugMode) {
          print('Não foi possível abrir $url');
        }
      }
    } else {
      if (kDebugMode) {
        print('Nenhum link social foi fornecido para o AppBar.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: AppColors.dark,
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            AppSpacing.space16,
          ), 
        ),
      ),
      centerTitle: true,
      title: Text(
        'Ateliê Thais Dornelas',
        style: AppTypography.appBarTitle,
      ),
      actions: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.instagram,
            color: AppColors.white,
          ),
          onPressed: _launchUrl,
        ),
        AppSpacing.horizontal8,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
