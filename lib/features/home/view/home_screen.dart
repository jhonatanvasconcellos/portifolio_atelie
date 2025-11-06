import 'package:atelie_portifolio/core/providers/selection_provider.dart';
import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:atelie_portifolio/features/fabrics/view/fabrics_page.dart';
import 'package:atelie_portifolio/features/home/provider/home_provider.dart';
import 'package:atelie_portifolio/features/info/view/info_page.dart';
import 'package:atelie_portifolio/features/models/view/models_page.dart';
import 'package:atelie_portifolio/core/providers/registration_provider.dart';
import 'package:atelie_portifolio/features/registration/view/registration_page.dart';
import 'package:atelie_portifolio/shared/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _pageController;

  final List<Widget> _pages = const [
    ModelsPage(),
    FabricsPage(),
    RegistrationPage(),
    InfoPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ref.read(homePageIndexProvider),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _sendWhatsAppMessage(WidgetRef ref, BuildContext context) async {
    final selection = ref.read(selectionProvider);
    final registration = ref.read(registrationProvider);

    if (registration.isEmpty) {
      ref.read(homePageIndexProvider.notifier).state = 2;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete seu cadastro para finalizar.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final String message =
        '''

Pedido via App Ateliê
---------------------
*Cliente:* ${registration.name}
*WhatsApp:* ${registration.whatsapp}
*Endereço:* ${registration.address}
*Email:* ${registration.email}

*Item Selecionado:*
- Modelo: ${selection.selectedModel!.name}
- Tecido: ${selection.selectedFabric!.name}

*Descrição do Modelo:*
${selection.selectedModel!.description}

*Descrição do Tecido:*
${selection.selectedFabric!.description}
''';

    const String storePhoneNumber = '5521970215891';
    final String encodedMessage = Uri.encodeComponent(message);
    final Uri whatsappUrl = Uri.parse(
      'https://wa.me/$storePhoneNumber?text=$encodedMessage',
    );

    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      if (kDebugMode) {
        print('Não foi possível abrir $whatsappUrl');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível abrir o WhatsApp. Verifique se ele está instalado.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = ref.watch(homePageIndexProvider);
    final selection = ref.watch(selectionProvider);
    final bool canFinalizeOrder =
        selection.selectedModel != null && selection.selectedFabric != null;

    return Scaffold(
      appBar: const CustomAppBar(
        socialLink: 'https://www.instagram.com/thaisdornelascostura',
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          ref.read(homePageIndexProvider.notifier).state = index;
        },
      ),
      floatingActionButton: canFinalizeOrder
          ? FloatingActionButton.extended(
              onPressed: () {
                _sendWhatsAppMessage(ref, context);
              },
              backgroundColor: Colors.green[600],
              icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
              label: const Text(
                'Finalizar Pedido',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.dark,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.7),

          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.personDress),
              label: 'Modelos',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.scissors),
              label: 'Tecidos',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userPen),
              label: 'Cadastro',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.circleInfo),
              label: 'Infos',
            ),
          ],
        ),
      ),
    );
  }
}
