import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/core/theme/app_spacing.dart';
import 'package:atelie_portifolio/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(
            'assets/videos/info.mp4', 
          )
          ..initialize().then((_) {
            _controller.setLooping(true);
            _controller.setVolume(0.0);
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.vertical24,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Conheça Nossas Regras',
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          AppSpacing.vertical24,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: Center(
              child: _controller.value.isInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        if (!_controller.value.isPlaying)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.play();
                              });
                            },
                            icon: const Icon(
                              Icons.play_circle_filled,
                              color: Colors.white70,
                              size: 64,
                            ),
                          ),
                      ],
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
            ),
          ),

          AppSpacing.vertical32,

          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.space24,
              horizontal: AppSpacing.space16,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.dark),
            child: Column(
              children: [
                _InfoSection(
                  icon: Icons.storefront,
                  title: 'Endereço da Loja',
                  text:
                      'Rua das Costureiras, 123, Bairro Centro\nCidade, Estado - CEP 00000-000',
                ),
                AppSpacing.vertical24,

                _InfoSection(
                  icon: Icons.phone,
                  title: 'Contato da Loja',
                  text: '(21) 99999-8888\ncontato@thaisdornelas.com',
                ),
                AppSpacing.vertical24,

                _InfoSection(
                  icon: FontAwesomeIcons.instagram,
                  title: 'Rede Social',
                  text: 'Siga-nos no Instagram: @thaisdornelascostura',
                  isInstagram: true,
                ),
                AppSpacing.vertical32,

                Center(
                  child: Text(
                    'Obrigado por escolher nosso ateliê!',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final bool isInstagram;

  const _InfoSection({
    required this.icon,
    required this.title,
    required this.text,
    this.isInstagram = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isInstagram
            ? const FaIcon(
                FontAwesomeIcons.instagram,
                color: AppColors.white,
                size: 28,
              )
            : Icon(icon, color: AppColors.white, size: 28),

        AppSpacing.horizontal16,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.titleCard.copyWith(color: AppColors.white),
              ),
              AppSpacing.vertical8,

              Text(
                text,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
